package controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import service.ProgramDao_usingHibernate;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.School;
import java.util.List;

@Controller
@RequestMapping("/program")  // Changed from "/schools" to match pattern
public class ProgramController {
    
    @Autowired
    private ProgramDao_usingHibernate schoolDao;

    @RequestMapping("/tvpssteam/schoolList")  // Changed to match pattern
    public String listSchools(Model model) {
        List<School> schools = schoolDao.findAll();
        model.addAttribute("schoolList", schools);  // Changed to match pattern
        return "schoolList";  // Make sure this JSP exists
    }

    @GetMapping("/tvpssteam/add")
    public String showAddForm(Model model) {
        model.addAttribute("school", new School());
        return "addSchool";
    }

    @PostMapping("/tvpssteam/add")
    public String saveSchool(@ModelAttribute("school") School school, RedirectAttributes redirectAttributes) {
        schoolDao.save(school);
        redirectAttributes.addFlashAttribute("successMessage", "School added successfully!");
        return "redirect:/program/tvpssteam/schoolList";  // Redirects back to the school list
    }
    
    @GetMapping("/tvpssteam/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        School school = schoolDao.findById(id);
        model.addAttribute("school", school);
        return "editSchool";
    }
    
    @PostMapping("/tvpssteam/update")
    public String updateSchool(@ModelAttribute("school") School school, RedirectAttributes redirectAttributes) {
        schoolDao.save(school);  
        redirectAttributes.addFlashAttribute("successMessage", "School information has been updated successfully!");
        return "redirect:/program/tvpssteam/schoolList";
    }
    @GetMapping("/tvpssteam/delete")
    public String deleteSchool(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        try {
            schoolDao.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "School deleted successfully!");
            return "redirect:/program/tvpssteam/schoolList";  // Redirect to the list page
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting school: " + e.getMessage());
            return "redirect:/program/tvpssteam/schoolList";
        }
    }

    @PostMapping("/delete")  // Changed to match pattern
    public String deleteSchool(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        schoolDao.delete(id);
        model.addAttribute("id", id);
        return "confirmdeletedschool";  // Changed to match naming pattern
    }
}