package order;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cart.CartDAO;
import coupon.CouponDTO;
import coupon.CouponMemberDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberDAO;
import member.MemberDTO;
import product.ProductDAO;
import product.ProductDTO;
import java.util.Arrays;

public class OrderController extends HttpServlet{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String url = request.getRequestURI();
		String path = request.getContextPath();
		HttpSession session = request.getSession();
		MemberDAO memberDAO = new MemberDAO();
		OrderDAO orderDAO = new OrderDAO();
		CartDAO cartDAO = new CartDAO();
		CouponMemberDAO couponmemberDAO = new CouponMemberDAO();
		System.out.println("order 시작: "+ url);
		
		if(url.indexOf("order.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			System.out.println("userID: "+ userID);
			MemberDTO memberDTO =  memberDAO.getMemberInfo(userID);
			request.setAttribute("Mdto",memberDTO);
			List<CouponDTO> ableList = couponmemberDAO.ableList(userID);
			request.setAttribute("ableList", ableList);
			
			String[] str_productNum = request.getParameterValues("productNum");
			System.out.println("str_productNum:"+ Arrays.toString(str_productNum));
	        String[] str_orderAmount = request.getParameterValues("cartAmount");
	        System.out.println("str_orderAmount:"+ Arrays.toString(str_orderAmount));
	        
	        List<ProductDTO> productList = new ArrayList<>();
	        List<Integer> orderAmountList = new ArrayList<>();
 
	        for (int i=0; i<str_productNum.length; i++) {
	        	int productNum = Integer.parseInt(str_productNum[i]);
	        	System.out.println("productNum:"+productNum);
	        	ProductDTO productDTO =  orderDAO.orderOne(productNum); // 배열을 set할 떄는?
	        	System.out.println("orderDTO:"+productDTO);
	        	int orderAmount = Integer.parseInt(str_orderAmount[i]);
	        	System.out.println("amount"+orderAmount);
	        	
	        	productList.add(productDTO);
	            orderAmountList.add(orderAmount);
	        }
	        request.setAttribute("productList", productList);
	        request.setAttribute("orderAmountList", orderAmountList);
	        
	        RequestDispatcher rd = request.getRequestDispatcher("/order/order_page.jsp");
	        rd.forward(request, response);		
		
		}
		else if (url.indexOf("insert.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			System.out.println("userID:"+userID);
			MemberDTO memberDTO =  memberDAO.getMemberInfo(userID);
			request.setAttribute("Mdto",memberDTO);
			
			int couponPrice = Integer.parseInt(request.getParameter("couponPrice"));
			System.out.println("couponPrice:"+couponPrice);
			request.setAttribute("couponPrice", couponPrice);
			

			String[] str_productNum = request.getParameterValues("productNum");
			System.out.println("str_productNum:"+ Arrays.toString(str_productNum));
	        String[] str_orderAmount = request.getParameterValues("orderAmount");
	        System.out.println("str_orderAmount:"+str_orderAmount);
	        System.out.println("str_orderAmount:"+ Arrays.toString(str_orderAmount));
	        Long orderDate = Long.parseLong(request.getParameter("orderDate"));
	        System.out.println("orderDate:"+orderDate);
	        String recipient = request.getParameter("recipient");
	        System.out.println("recipient:"+recipient);
			String rec_phoneNum = request.getParameter("rec_phoneNum");
			System.out.println("rec_phoneNum:"+rec_phoneNum);
			int zipCode = Integer.parseInt(request.getParameter("zipCode"));
			System.out.println("zipCode:"+zipCode);
			String address = request.getParameter("address");
			System.out.println("address:"+address);
			String addressDetail = request.getParameter("addressDetail");
			System.out.println("addressDetail:"+addressDetail);
			
			int couponID = Integer.parseInt(request.getParameter("couponID"));
			System.out.println("couponID:"+couponID);
			couponmemberDAO.selected(couponID, orderDate);

			
	        List<ProductDTO> productList = new ArrayList<>();
	        List<Integer> orderAmountList = new ArrayList<>();
// 배열로 안할 수도
	        
	        for (int i=0; i<str_productNum.length; i++) {
	        	OrderDTO orderDTO = new OrderDTO();
	        	orderDTO.setUserID(userID);
				orderDTO.setProductNum(Integer.parseInt(str_productNum[i]));
				ProductDTO productDTO =  orderDAO.orderOne(Integer.parseInt(str_productNum[i]));
				orderDTO.setOrderAmount(Integer.parseInt(str_orderAmount[i]));
				orderDTO.setOrderDate(orderDate);
				orderDTO.setRecipient(recipient);
				orderDTO.setRec_phoneNum(rec_phoneNum);
				orderDTO.setZipCode(zipCode);
				orderDTO.setAddress(address);
				orderDTO.setAddressDetail(addressDetail);
				orderDAO.insert(orderDTO);
				cartDAO.ordered_delete(userID,Integer.parseInt(str_productNum[i]));
				
				productList.add(productDTO);
	            orderAmountList.add(Integer.parseInt(str_orderAmount[i]));

	        }
	        request.setAttribute("productList", productList);
	        request.setAttribute("orderAmountList", orderAmountList);


	        
	        Map<String, Object> map = new HashMap<String, Object>();
			map.put("recipient", recipient);
			map.put("rec_phoneNum", rec_phoneNum);
			map.put("zipCode", zipCode);
			map.put("address", address);
			map.put("addressDetail", addressDetail);
			request.setAttribute("map", map);

			RequestDispatcher rd = request.getRequestDispatcher("/order/order_result.jsp");
			rd.forward(request, response);
			// 오더 테이블에 수량, 상품 정보 넣기 테이블 수정a
		}
		
		else if (url.indexOf("list.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			System.out.println("list userid:"+userID);
			List<OrderDTO> orderList = orderDAO.orderList(userID);
			System.out.println("list:"+orderList);
			request.setAttribute("orderList", orderList);
			RequestDispatcher rd = request.getRequestDispatcher("/order/order_list.jsp");
			rd.forward(request, response);
		}
		
		else if (url.indexOf("detail.do")!=-1) {
			String userID = (String)session.getAttribute("userID");
			System.out.println("userID:"+userID);
			Long orderDate = Long.parseLong(request.getParameter("orderDate"));
			System.out.println("orderDate:"+orderDate);
			CouponDTO couponDTO = couponmemberDAO.detail(orderDate, userID);
			System.out.println("couponDTO:"+couponDTO);
			request.setAttribute("Cdto", couponDTO);
			int orderNum = Integer.parseInt(request.getParameter("orderNum"));
			System.out.println("orderNum:"+orderNum);
			OrderDTO orderDTO = orderDAO.detailOne(orderDate, orderNum);
			System.out.println("orderDTO:"+orderDTO);
			request.setAttribute("Odto", orderDTO);
			List<OrderDTO> orderList = orderDAO.detailAll(orderDate);
			System.out.println("orderedList:"+orderList);
			request.setAttribute("orderedList", orderList);
			RequestDispatcher rd = request.getRequestDispatcher("/order/order_detail.jsp");
			rd.forward(request, response);
		}
		
		else if (url.indexOf("delete.do")!=-1) {
			int orderNum = Integer.parseInt(request.getParameter("orderNum"));
			System.out.println("orderNum"+orderNum);
			orderDAO.delete(orderNum);
			response.sendRedirect(path +"/member/myPageHome.jsp");
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		doGet(request, response);
	}
}
