/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller.Common;

import DTO.PostDTO;
import Model.Address;
import Model.House;
import Model.Like;
import Model.Media;
import Model.User;
import Model.Post;
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
        try {
            String searchKey = request.getParameter("searchKey");
            String type = request.getParameter("type");
            String page = request.getParameter("page");

            // Default values
            if (searchKey == null || searchKey.trim().isEmpty()) {
                searchKey = "";
            }
            if (type == null || type.trim().isEmpty()) {
                type = "all";
            }

            int currentPage = 1;
            if (page != null && !page.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(page);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            int limit = 10;
            int offset = (currentPage - 1) * limit;

            // Initialize result lists
            List<House> houses = new ArrayList<>();
            List<User> users = new ArrayList<>();
            List<Post> posts = new ArrayList<>();

            int totalHouses = 0;
            int totalUsers = 0;
            int totalPosts = 0;

            // Search based on type
            switch (type.toLowerCase()) {
                case "houses":
                    houses = hDao.getListPaging(limit, offset, searchKey.trim(), "");
                    fullLoadHouseInformation(houses);
                    totalHouses = hDao.getListPaging(Integer.MAX_VALUE, 0, searchKey.trim(), "").size();
                    break;

                case "users":
                    users = uDao.searchUsers(searchKey.trim(), limit, offset);
                    totalUsers = uDao.countSearchUsers(searchKey.trim());
                    break;

                case "posts":
                    posts = pDao.searchPosts(searchKey.trim(), limit, offset);
                    fullLoadPostInfomation(posts, user);
                    totalPosts = pDao.countSearchPosts(searchKey.trim());
                    break;

                case "all":
                default:
                    // Search all types with smaller limits
                    int allLimit = 5;
                    houses = hDao.getListPaging(allLimit, 0, searchKey.trim(), "");
                    fullLoadHouseInformation(houses);
                    totalHouses = hDao.getListPaging(Integer.MAX_VALUE, 0, searchKey.trim(), "").size();

                    users = uDao.searchUsers(searchKey.trim(), allLimit, 0);
                    totalUsers = uDao.countSearchUsers(searchKey.trim());

                    posts = pDao.searchPosts(searchKey.trim(), allLimit, 0);
                    fullLoadPostInfomation(posts, user);
                    totalPosts = pDao.countSearchPosts(searchKey.trim());
                    break;
            }

            // Calculate pagination
            int totalResults = totalHouses + totalUsers + totalPosts;
            int totalPages = (int) Math.ceil((double) totalResults / limit);
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
            LOGGER.log(Level.SEVERE, "Something wrong happened in search controller!", e);
            request.setAttribute("error", "An error occurred while searching. Please try again.");
            request.getRequestDispatcher("./FE/Common/Search.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPostAuthorized(HttpServletRequest request, HttpServletResponse response, User user) throws ServletException, IOException {
        // Handle POST requests (e.g., for advanced search filters)
        doGetAuthorized(request, response, user);
    }

    private void fullLoadHouseInformation(List<House> houses) {
        try {
            for (House h : houses) {
                if (h != null && h.getId() != null) {
                    String hid = h.getId();

                    Address a = aDao.getAddressById(h.getAddress().getId());
                    h.setAddress(a);

                    if (h.getOwner() != null && h.getOwner().getId() != null) {
                        User owner = uDao.getById(h.getOwner().getId());
                        h.setOwner(owner);
                    }
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadHouseInformation process", e);
        }
    }

    private void fullLoadPostInfomation(List<Post> posts, User user) {
        try {
            for (Post p : posts) {
                String pid = p.getId();

                Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

                Status s = new Status();
                s.setId(21);

                List<Media> medias = mDao.getMediaByObjectId(p.getId(), "Post", s);
                List<Like> likes = lDao.getListLikeByPostId(pid);
                List<Review> reviews = rDao.getReviewsByHouseId(p.getHouse().getId(), Integer.MAX_VALUE, 0);

                Post parent = null;

                if (p.getParent_post() != null && p.getParent_post().getId() != null) {
                    parent = pDao.getById(p.getParent_post().getId());
                    fullLoadParentPost(parent);
                }

                boolean isLikedByCurrentUser = false;
                if (user != null && !user.getId().isBlank()) {
                    isLikedByCurrentUser = likes.stream()
                            .anyMatch(like -> like.getUser_id().equals(user.getId()) && like.isIs_like());
                }

                p.setReviews(reviews);
                p.getHouse().setAddress(a);
                p.setMedias(medias);
                p.setLikes(likes);
                p.setLikedByCurrentUser(isLikedByCurrentUser);
                p.setParent_post(parent);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadParentPost(Post p) {
        try {
            //Load address, images, likes, feedbacks
            String pid = p.getId();

            Address a = aDao.getAddressById(p.getHouse().getAddress().getId());

            Status s = new Status();
            s.setId(21);

            List<Media> medias = mDao.getMediaByObjectId(pid, "Post", s);

            p.getHouse().setAddress(a);
            p.setMedias(medias);

            fullLoadHouseParentPostInfomation(p.getHouse());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }

    private void fullLoadHouseParentPostInfomation(House h) {
        try {
            //Load address, images, likes, feedbacks
            String hid = h.getId();

            Address a = aDao.getAddressById(h.getAddress().getId());
            Status mediaS = new Status();
            mediaS.setId(21);
            List<Media> medias = mDao.getMediaByObjectId(hid, "Homestay", mediaS);

            h.setMedias(medias);
            h.setAddress(a);

        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error during fullLoadPostInfomation process", e);
            log.error("Error during fullLoadPostInfomation process");
        }
    }
}
