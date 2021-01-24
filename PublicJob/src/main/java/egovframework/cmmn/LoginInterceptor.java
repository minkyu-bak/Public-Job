package egovframework.cmmn;
//관련 설정 1)web.xml 2)webapp/WEB-INF/egovframeworl/springmvc/dispatcher-servlet.xml
//preHandle : Controller가 호출되기 전 수행
//postHandle : Controller가 완료된 이후에 수행
//afterCompletion : Controller 수행 후 view단 작업까지 완료 된 후 호출 


import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ExtendedModelMap;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.admin_login.service.AdminVO;


public class LoginInterceptor extends HandlerInterceptorAdapter {
    /**
     * 세션에 계정정보(AdminVO)가 있는지 여부로 인증 여부를 체크한다. 계정정보(AdminVO)가 없다면, 로그인 페이지로 이동한다.
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        AdminVO adminVO = null;
       
        try {
        	adminVO = (AdminVO) request.getSession().getAttribute("adminLoginSessionInfo");
            if (adminVO != null && adminVO.getAdminId() != null) {
                return true;
            } else {

            	// 로그인 페이지로 이동
            	request.setAttribute("msg", "로그인이 필요합니다.");
            	response.sendRedirect("admin_Login");

               // 컨트롤러를 실행하지 않는다.(요청페이지로 이동하지 않는다)
                return false;
            }
        } catch (Exception e) {
            ModelAndView modelAndView = new ModelAndView("admin_Login");
            modelAndView.addObject("msg", "로그인이 필요합니다.");
            throw new ModelAndViewDefiningException(modelAndView);
        }
    }

    
    
    
    
    
    
    
    
    /**
     * 세션에 메뉴권한(LoginVO.userGubun)을 가지고 메뉴를 조회하여 권한 여부를 체크한다.
     */
//    @Override
//    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//    	AdminVO adminVO = null;
//        String requestURI = request.getRequestURI();
//        
//        try {
//        	
//         if(!"admin_Login".equals(requestURI)) {
//        	 adminVO = (AdminVO) request.getSession().getAttribute("adminLoginSessionInfo");
//        	 
//          if (adminVO != null && adminVO.getAdminId() != null) {//로그인 세션이 있을 경우
////           SearchVO searchVO = new SearchVO();
////           searchVO.setSchMenuUrl(requestURI);
////           searchVO.setSchUserGubun(adminVO.getAdminPermission());
////           List<?> resultList = sysadmService.getSelectRollMenuCheckList(searchVO);
//        	 
//           
//           ArrayList<String> PermissionList = new ArrayList<String> (Arrays.asList("S","A","B"));
////           if(resultList == null || resultList.size() == 0) {S
//
//   			if(requestURI.getBytes("Permission")!=null){
//   				ModelAndView mav = new ModelAndView("admin_Main"); 
//                     mav.addObject("msg", "권한이 없습니다.");
//                     throw new ModelAndViewDefiningException(mav);
//           }
//           
//          } else {//로그인 세션이 없을 경우
//           ModelAndView mav = new ModelAndView("admin_Login");
//           mav.addObject("msg", "로그인이 필요합니다.");
//           throw new ModelAndViewDefiningException(mav);
//          }
//         }
//         
//         
//         
//        } catch (Exception e) {
//            ModelAndView mav = new ModelAndView("forward:/monitorView.do"); 
//            mav.addObject("msg", "권한이 없습니다.");
//            throw new ModelAndViewDefiningException(mav);
//        }    }
}