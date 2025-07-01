/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Common;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author nongducdai
 */
@WebServlet(name = "VNPayReturnController", urlPatterns = {"/vnpay-return"})
public class VNPayReturnController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_Amount = request.getParameter("vnp_Amount");
        double amount = Double.parseDouble(vnp_Amount) / 100;

        switch (vnp_ResponseCode) {
            case "00" ->
                HandleSuccessPayment(request, response);
            case "24" ->
                HandleCancelPayment(request, response);
            case "15" ->
                HandleTimeoutPayment(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void HandleSuccessPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    protected void HandleCancelPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
    protected void HandleTimeoutPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
