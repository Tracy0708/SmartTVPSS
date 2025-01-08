package controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import service.SchoolDao_usingHibernate;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import entity.School;
import java.util.List;

@Controller
@RequestMapping("/school")  // Changed from "/schools" to match pattern
public class SchoolController {
    
    @Autowired
    private SchoolDao_usingHibernate schoolDao;

    @RequestMapping("/schoolList")  // Changed to match pattern
    public String listSchools(Model model) {
        List<School> schools = schoolDao.findAll();
        model.addAttribute("schoolList", schools);  // Changed to match pattern
        return "schoolList";  // Make sure this JSP exists
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        School school = new School();
        model.addAttribute("school", school);
        return "addSchool";  // Changed to match naming pattern
    }

    @PostMapping("/add")  // Changed to match pattern
    public String saveSchool(@ModelAttribute("school") School school, Model model) {
        schoolDao.save(school);
        model.addAttribute("school", school);
        return "confirmaddedschool";  // Changed to match naming pattern
    }

    @GetMapping("/delete")  // Changed to match pattern
    public String showDeleteForm() {
        return "formdeleteschool";  // Changed to match naming pattern
    }

    @PostMapping("/delete")  // Changed to match pattern
    public String deleteSchool(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        schoolDao.delete(id);
        model.addAttribute("id", id);
        return "confirmdeletedschool";  // Changed to match naming pattern
    }
}