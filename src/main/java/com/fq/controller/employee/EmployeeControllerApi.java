package com.fq.controller.employee;


import com.fq.dao.EmployeeMapper;
import com.fq.domain.Employee;
import com.fq.domain.ResultMsg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class EmployeeControllerApi {
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private ResultMsg resultMsg;
    //返回员工列表
    @GetMapping("/EmployeeList")
    public List<Employee> getEmployeeList(){
        List<Employee> employees = employeeMapper.selectAll();
        return employees;
    }

    //添加员工
    @RequestMapping(value = "/addEmployee" ,method = RequestMethod.POST)
    public ResultMsg addEmployee(Employee employee){
            try {
                //效验年龄是否合法
                if(employee.getAge()==null||"".equals(employee.getAge())){
                    resultMsg.setSuccess(false);
                    resultMsg.setMsg("请输入年龄");
                    return resultMsg;
                }
                else if(employee.getAge()!=null&&"".equals(employee.getAge())){
                    if(employee.getAge()<=0||employee.getAge()>120) {
                        resultMsg.setSuccess(false);
                        resultMsg.setMsg("年龄不合法");
                        return resultMsg;
                    }
                }
                //效验姓名是否为空
                else if(employee.getName()==null||"".equals(employee.getName())){
                    resultMsg.setSuccess(false);
                    resultMsg.setMsg("请输入姓名");
                    return resultMsg;
                }
                //效验性别是否合法
                else if(!("男".equals(employee.getGender())||"女".equals(employee.getGender()))){
                    resultMsg.setSuccess(false);
                    resultMsg.setMsg("性别只能为男或女");
                    return resultMsg;
                }
                //效验地址正确性
                else if(employee.getAddress()==null||"".equals(employee.getAddress())){
                    resultMsg.setSuccess(false);
                    resultMsg.setMsg("请输入地址");
                    return resultMsg;
                }
                else {
                    employeeMapper.insert(employee);
                    resultMsg.setSuccess(true);
                    resultMsg.setMsg("添加成功");
                }
        }catch (Exception e){
                e.printStackTrace();
                resultMsg.setMsg("未知错误");
                return resultMsg;
            }
            return resultMsg;
    }

    //更新员工
    @RequestMapping(value = "/updateEmployee" ,method = RequestMethod.PUT)
    public ResultMsg updateEmployee(Employee employee){
        try {
            //效验年龄是否合法
            if(employee.getAge()==null||"".equals(employee.getAge())){
                resultMsg.setSuccess(false);
                resultMsg.setMsg("请输入年龄");
                return resultMsg;
            }
            else if(employee.getAge()!=null&&"".equals(employee.getAge())){
                if(employee.getAge()<=0||employee.getAge()>120) {
                    resultMsg.setSuccess(false);
                    resultMsg.setMsg("年龄不合法");
                    return resultMsg;
                }
            }
            //效验姓名是否为空
            else if(employee.getName()==null||"".equals(employee.getName())){
                resultMsg.setSuccess(false);
                resultMsg.setMsg("请输入姓名");
                return resultMsg;
            }
            //效验性别是否合法
            else if(!("男".equals(employee.getGender())||"女".equals(employee.getGender()))){
                resultMsg.setSuccess(false);
                resultMsg.setMsg("性别只能为男或女");
                return resultMsg;
            }
            //效验地址正确性
            else if(employee.getAddress()==null||"".equals(employee.getAddress())){
                resultMsg.setSuccess(false);
                resultMsg.setMsg("请输入地址");
                return resultMsg;
            }
            else {
                employeeMapper.updateByPrimaryKey(employee);
                resultMsg.setSuccess(true);
                resultMsg.setMsg("更新成功");
            }
        }catch (Exception e){
            e.printStackTrace();
            resultMsg.setMsg("未知错误");
            return resultMsg;
        }
        return resultMsg;
    }

    //删除员工
    @RequestMapping(value = "/deleteEmployee/{id}" ,method = RequestMethod.DELETE)
    public ResultMsg deleteEmployee(@PathVariable Integer id){
        try {
            employeeMapper.deleteByPrimaryKey(id);
            resultMsg.setSuccess(true);
            resultMsg.setMsg("删除成功");
        }catch (Exception e){
            e.printStackTrace();
            resultMsg.setMsg("删除失败");
            return resultMsg;
        }
        return resultMsg;
    }
}
