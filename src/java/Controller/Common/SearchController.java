/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import Model.Address;
import Model.House;
import Model.Like;
import Model.Media;
import Model.User;
import Model.Post;
import Model.PostType;
import Model.Review;
import Model.Status;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 *
 * @author Tam
 */
@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends BaseAuthorization {

    private static final Logger LOGGER = Logger.getLogger(SearchController.class.getName());

    @Override
    protected void doGetAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        try {
            String searchKey = request.getParameter("searchKey");
            String type = request.getParameter("type");
            String page = request.getParameter("page");

            if (searchKey == null || searchKey.trim().isEmpty()) {
                searchKey = "";
            }
            if (type == null || type.trim().isEmpty()) {
                type = "users";
            }

            int currentPage = 1;
            if (page != null && !page.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(page);
                    if (currentPage < 1) {
                        currentPage = 1;
                    }
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            int limit = 5;
            int offset = (currentPage - 1) * limit;

            List<House> houses = new ArrayList<>();
            List<User> users = new ArrayList<>();
            List<Post> posts = new ArrayList<>();

            int totalHouses = 0;
            int totalUsers = 0;
            int totalPosts = 0;

            try {
                switch (type.toLowerCase().trim()) {
                    case "houses" -> {
                        houses = hDao.getListPaging(limit, offset, searchKey.trim(), "");
                        if (houses != null) {
                            fullLoadHouseInformation(houses);
                            totalHouses = hDao.getListPaging(Integer.MAX_VALUE, 0, searchKey.trim(), null).size();
                        }
                    }

                    case "users" -> {
                        users = uDao.searchUsers(searchKey.trim(), limit, offset);
                        if (users != null) {
                            totalUsers = uDao.countSearchUsers(searchKey.trim());
                        }
                    }

                    case "posts" -> {
                        posts = pDao.searchPosts(searchKey.trim(), limit, offset);
                        if (posts != null) {
                            fullLoadPostInfomation(posts, user);
                            totalPosts = pDao.countSearchPosts(searchKey.trim());
                        }
                    }
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error during search operations", e);
                houses = new ArrayList<>();
                users = new ArrayList<>();
                posts = new ArrayList<>();
                totalHouses = totalUsers = totalPosts = 0;
            }

            int totalResults = totalHouses + totalUsers + totalPosts;
            int totalPages = 1; // Default to 1 page

            switch (type.toLowerCase().trim()) {
                case "houses":
                    totalPages = (int) Math.ceil((double) totalHouses / limit);
                    break;
                case "users":
                    totalPages = (int) Math.ceil((double) totalUsers / limit);
                    break;
                case "posts":
                    totalPages = (int) Math.ceil((double) totalPosts / limit);
                    break;
            }

            if (totalPages < 1) {
                totalPages = 1;
            }

            boolean hasMore = currentPage < totalPages;
            boolean hasPrevious = currentPage > 1;

            // Set attributes for JSP
            request.setAttribute("houses", houses);
            request.setAttribute("users", users);
            request.setAttribute("posts", posts);
            request.setAttribute("totalHouses", totalHouses);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalPosts", totalPosts);
            request.setAttribute("totalResults", totalResults);
            request.setAttribute("searchKey", searchKey.trim());
            request.setAttribute("type", type);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("hasMore", hasMore);
            request.setAttribute("hasPrevious", hasPrevious);

            // Forward to JSP
            request.getRequestDispatcher("./FE/Common/Search.jsp").forward(request, response);

        } catch (ServletException | IOException e) {
            LOGGER.log(Level.SEVERE, "Fatal error in search controller", e);

            // Set error attributes
            request.setAttribute("error", "An error occurred while searching. Please try again.");
            request.setAttribute("houses", new ArrayList<>());
            request.setAttribute("users", new ArrayList<>());
            request.setAttribute("posts", new ArrayList<>());
            request.setAttribute("totalHouses", 0);
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalPosts", 0);
            request.setAttribute("totalResults", 0);
            request.setAttribute("searchKey", "");
            request.setAttribute("type", "all");
            request.setAttribute("currentPage", 1);
            request.setAttribute("totalPages", 1);
            request.setAttribute("hasMore", false);
            request.setAttribute("hasPrevious", false);

            // Only forward once
            try {
                request.getRequestDispatcher("./FE/Common/Search.jsp").forward(request, response);
            } catch (ServletException | IOException forwardException) {
                LOGGER.log(Level.SEVERE, "Error forwarding to error page", forwardException);
            }
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        // Handle POST requests (e.g., for advanced search filters)
        doGetAuthorized(request, response, user);
    }

    private void fullLoadHouseInformation(List<House> houses) {
        if (houses == null || houses.isEmpty()) {
            return;
        }

        try {
            for (House h : houses) {
                if (h != null && h.getId() != null) {
                    try {
                        String hid = h.getId();

                        Address a = aDao.getAddressById(h.getAddress().getId());
                        if (a != null) {
                            h.setAddress(a);
                        }

                        if (h.getOwner() != null && h.getOwner().getId() != null) {
                            User owner = uDao.getById(h.getOwner().getId());
                            if (owner != null) {
                                h.setOwner(owner);
                            }
                        }
                    } catch (Exception e) {
                        LOGGER.log(Level.WARNING, "Error loading house information for house ID: " + h.getId(), e);
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadHouseInformation process", e);
        }
    }

    private void fullLoadPostInfomation(List<Post> posts, User user) {
        if (posts == null || posts.isEmpty()) {
            return;
        }

        try {
            for (Post p : posts) {
                if (p == null || p.getId() == null) {
                    continue;
                }

                try {
                    String pid = p.getId();

                    // Load address
                    Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
                    if (a != null) {
                        p.getHouse().setAddress(a);
                    }

                    // Load media
                    Status s = new Status();
                    s.setId(21);
                    List<Media> medias = mDao.getMediaByObjectId(p.getId(), "Post", s);
                    if (medias != null) {
                        p.setMedias(medias);
                    }

                    // Load likes
                    List<Like> likes = lDao.getListLikeByPostId(pid);
                    if (likes != null) {
                        p.setLikes(likes);
                    }

                    // Load reviews
                    if (p.getHouse() != null && p.getHouse().getId() != null) {
                        List<Review> reviews = rDao.getReviewsByHouseId(p.getHouse().getId(), Integer.MAX_VALUE, 0);
                        if (reviews != null) {
                            p.setReviews(reviews);
                        }
                    }

                    // Load parent post
                    Post parent = null;
                    if (p.getParent_post() != null && p.getParent_post().getId() != null) {
                        parent = pDao.getById(p.getParent_post().getId());
                        if (parent != null) {
                            fullLoadParentPost(parent);
                        }
                    }
                    p.setParent_post(parent);

                    PostType pt = ptDao.getPostTypeById(p.getPost_type().getId());
                    p.setPost_type(pt);

                    // Check if liked by current user
                    boolean isLikedByCurrentUser = false;
                    if (user != null && user.getId() != null && !user.getId().isBlank() && likes != null) {
                        isLikedByCurrentUser = likes.stream()
                                .anyMatch(like -> like.getUser_id().equals(user.getId()) && like.isIs_like());
                    }
                    p.setLikedByCurrentUser(isLikedByCurrentUser);

                } catch (Exception e) {
                    LOGGER.log(Level.WARNING, "Error loading post information for post ID: " + p.getId(), e);
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
        }
    }

    private void fullLoadParentPost(Post p) {
        if (p == null || p.getId() == null) {
            return;
        }

        try {
            String pid = p.getId();

            // Load address
            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());
            if (a != null) {
                p.getHouse().setAddress(a);
            }

            // Load media
            Status s = new Status();
            s.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(pid, "Post", s);
            if (medias != null) {
                p.setMedias(medias);
            }

            if (p.getHouse() != null) {
                fullLoadHouseParentPostInfomation(p.getHouse());
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadParentPost process for post ID: " + p.getId(), e);
        }
    }

    private void fullLoadHouseParentPostInfomation(House h) {
        if (h == null || h.getId() == null) {
            return;
        }

        try {
            String hid = h.getId();

            // Load address
            Address a = aDao.getAddressById(h.getAddress().getId());
            if (a != null) {
                h.setAddress(a);
            }

            // Load media
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);
            if (medias != null) {
                h.setMedias(medias);
            }

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadHouseParentPostInfomation process for house ID: " + h.getId(), e);
        }
    }
}
