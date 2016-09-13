package com.leoman.carrental.controller;

import com.leoman.bus.entity.Bus;
import com.leoman.bus.entity.CarType;
import com.leoman.bus.service.BusService;
import com.leoman.bus.service.CarTypeService;
import com.leoman.bussend.entity.BusSend;
import com.leoman.bussend.service.BusSendService;
import com.leoman.carrental.entity.CarRental;
import com.leoman.carrental.entity.CarRentalOffer;
import com.leoman.carrental.service.CarRentalOfferService;
import com.leoman.carrental.service.CarRentalService;
import com.leoman.carrental.service.impl.CarRentalServiceImpl;
import com.leoman.city.entity.City;
import com.leoman.city.service.CityService;
import com.leoman.common.controller.common.GenericEntityController;
import com.leoman.common.factory.DataTableFactory;
import com.leoman.common.service.Query;
import com.leoman.user.entity.UserInfo;
import com.leoman.utils.DateUtils;
import com.leoman.utils.JsonUtil;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/9/7.
 */
@Controller
@RequestMapping(value = "/admin/carRental")
public class CarRentalController extends GenericEntityController<CarRental,CarRental,CarRentalServiceImpl> {

    @Autowired
    private CarRentalService carRentalService;
    @Autowired
    private BusSendService busSendService;
    @Autowired
    private CarRentalOfferService carRentalOfferService;
    @Autowired
    private CityService cityService;
    @Autowired
    private CarTypeService carTypeService;
    @Autowired
    private BusService busService;

//    public static List<CarRental> list;

    @RequestMapping(value = "/index")
    public String index(){
        return "carrental/list";
    }

    /**
     * 列表
     * @param draw
     * @param start
     * @param length
     * @return
     */
    @RequestMapping(value = "/list")
    @ResponseBody
    public Map<String, Object> list(HttpServletRequest request,Model model,Integer draw, Integer start, Integer length, String orderNo,Integer orderStatus,String carNo,String driverName,String userName,String Dstart,String Dend) throws ParseException {
        int pagenum = getPageNum(start, length);
        Query query = Query.forClass(CarRental.class, carRentalService);
        query.setPagenum(pagenum);
        query.setPagesize(length);

        if(StringUtils.isNotBlank(orderNo)){
            query.like("order.orderNo",orderNo);
        }

        if(orderStatus!=null){
            query.eq("order.status",orderStatus);
        }

        if(StringUtils.isNotBlank(userName)){
            query.like("order.userName",userName);
        }

        if(StringUtils.isNotBlank(Dstart)){
            query.ge("startDate",DateUtils.stringToLong(Dstart,"yyyy-MM-dd"));
        }
        if( StringUtils.isNotBlank(Dend)){
            query.le("startDate",DateUtils.stringToLong(Dend,"yyyy-MM-dd"));
        }


        if(StringUtils.isNotBlank(carNo) || StringUtils.isNotBlank(driverName)){
            List<Long> ids = busSendService.findIds(carNo,driverName);
            if(!ids.isEmpty()){
                query.in("id",ids);
            }else {
                //没有查询到任何相关信息
                query.eq("id",0);
            }
        }

        Page<CarRental> page = carRentalService.queryPage(query);
        List<CarRental> carRentals = page.getContent();
        List list = new ArrayList();
        list.addAll(carRentals);
//        Double sumTotalAmount = 0.0;
//        Double sumIncome = 0.0;
//        Double sumRefund = 0.0;
//
//        for(int i=0;i<length;i++){
//            if(i<carRentals.size()){
//                sumTotalAmount += carRentals.get(i).getTotalAmount();
//                sumIncome += carRentals.get(i).getIncome();
//                sumRefund += carRentals.get(i).getRefund();
//            }else {
//                break;
//            }
//        }
////
//        model.addAttribute("sumTotalAmount",sumTotalAmount);
//        model.addAttribute("sumIncome",sumIncome);
//        model.addAttribute("sumRefund",sumRefund);
//
//        CarRental _c = new CarRental();
//        _c.setTotalAmount(sumTotalAmount);
//        _c.setIncome(sumIncome);
//        _c.setRefund(sumRefund);
//        list.add(_c);

        HttpSession session = request.getSession();
        session.setAttribute("carRentals" , list);

        return DataTableFactory.fitting(draw, page);

    }

    @RequestMapping(value = "/detail")
    public String detail(Long id, Model model){
        //租车
        model.addAttribute("carRental",carRentalService.queryByPK(id));
        //巴士
        model.addAttribute("busSend",busSendService.findBus(id,2));
        //报价
        List<CarRentalOffer> carRentalOffer = carRentalOfferService.queryByProperty("rentalId",id);
        model.addAttribute("carRentalOffer",carRentalOffer);
        //金额
        Double totalAmount = 0.0;
        for(CarRentalOffer c : carRentalOffer){
            totalAmount += c.getAmount();
        }
        model.addAttribute("totalAmount",totalAmount);
        return "carrental/detail";
    }

    @RequestMapping(value = "/edit")
    private String edit(Long id, Model model,Integer status){
        //租车
        model.addAttribute("carRental",carRentalService.queryByPK(id));

        model.addAttribute("city",cityService.queryAll());

        model.addAttribute("carType",carTypeService.queryAll());
        //报价
        List<CarRentalOffer> carRentalOffer = carRentalOfferService.queryByProperty("rentalId",id);
        model.addAttribute("carRentalOffer",carRentalOffer);
        //巴士
        model.addAttribute("busSend",busSendService.findBus(id,2));
        //金额
        Double totalAmount = 0.0;
        for(CarRentalOffer c : carRentalOffer){
            totalAmount += c.getAmount();
        }
        model.addAttribute("totalAmount",totalAmount);
        if(status==0){
            return "carrental/edit1";
        }else{
            return "carrental/edit2";
        }
    }

    /**
     * 保存
     * @param id
     * @param cityId
     * @param rwType
     * @param startPoint
     * @param endPoint
     * @param startDate
     * @param endDate
     * @param carTypeId
     * @param totalNumber
     * @param busNum
     * @param isInvoice
     * @param invoice
     * @param dispatch
     * @param offter_name
     * @param offter_amount
     * @return
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public Integer save(Long id,
                        Long cityId,
                        Integer rwType,
                        String startPoint,
                        String endPoint,
                        String startDate,
                        String endDate,
                        Long carTypeId,
                        Integer totalNumber,
                        Integer busNum,
                        Integer isInvoice,
                        String invoice,
                        String dispatch,
                        String offter_name,
                        String offter_amount){

        return carRentalService.save(id,cityId,rwType,startPoint,endPoint,startDate,endDate,carTypeId,totalNumber,busNum,isInvoice,invoice,dispatch,offter_name,offter_amount);

    }

    /**
     * 重新派车
     * @param id
     * @param dispatch
     * @return
     */
    @RequestMapping(value = "/saveDispatch")
    @ResponseBody
    public Integer saveDispatch(Long id,String dispatch){

        return carRentalService.saveDispatch(id,dispatch);

    }

    /**
     * 删除
     * @param id
     * @return
     */
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Integer del(Long id) {
        return carRentalService.del(id);
    }


    //历史记录
    /**
     * 跳转历史记录
     * @return
     */
    @RequestMapping(value = "/history/index")
    public String historyIndex(){
        return "carrental/history/list";
    }

    /**
     * 历史详情
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/history/detail")
    public String historyDetail(Long id, Model model){

        model.addAttribute("carRental",carRentalService.queryByPK(id));
        //巴士
        model.addAttribute("busSend",busSendService.findBus(id,2));

        return "carrental/history/detail";
    }



    //收入明细
    @RequestMapping(value = "/income/index")
    public String incomeIndex(){
        return "carrental/income/list";
    }


    @RequestMapping(value = "/income/detail")
    public String incomeDetail(Long id, Model model){

        model.addAttribute("carRental",carRentalService.queryByPK(id));
        //巴士
        model.addAttribute("busSend",busSendService.findBus(id,2));
        //报价
        List<CarRentalOffer> carRentalOffer = carRentalOfferService.queryByProperty("rentalId",id);
        model.addAttribute("carRentalOffer",carRentalOffer);

        return "carrental/income/detail";
    }

//    @RequestMapping(value = {"/exportFeedback"})
//    public void exportFeedback(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> map, Integer type) throws Exception {
//        List<Map<String, Object>> list = questionService.pageToExcel(map,type);
//        ExcelUtil.createExcel(USER_TEMPLATE, USER_FIELD, list, tempFilePath);
//        download(request, response, USER_EXCEL_NAME);
//    }


}
