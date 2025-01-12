package controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Talent;
import service.TalentDao_usingHibernate;

@Controller
@RequestMapping("/talent")
public class TalentController {
	@Autowired // spring dependency injection
	private TalentDao_usingHibernate tDao_usingHibernate;

	@RequestMapping("/admin/talentList")
	public String getAllTalent(Model model) {
		List<Talent> talentList = tDao_usingHibernate.findAll();
		model.addAttribute("talentList", talentList);
		return "talentList";
	}

	 @PostMapping(value = "/admin/talentList", 
             consumes = MediaType.APPLICATION_JSON_VALUE, 
             produces = MediaType.APPLICATION_JSON_VALUE)
 @ResponseBody
 public ResponseEntity<?> scheduleInterview(@RequestBody Map<String, Object> interviewData) {
     try {
         // Extract data from the request
         int id = ((Number) interviewData.get("id")).intValue();
         String interviewDate = (String) interviewData.get("interviewDate");
         String interviewTime = (String) interviewData.get("interviewTime");

         // Parse the date
         SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
         Date parsedDate = dateFormat.parse(interviewDate);

         // Get the talent by ID
         Talent talent = tDao_usingHibernate.findById(id);
         if (talent == null) {
             return ResponseEntity.status(HttpStatus.NOT_FOUND)
                 .body(Map.of("success", false, "message", "Talent not found"));
         }

         // Update interview details
         talent.setInterviewDate(parsedDate);
         talent.setInterviewTime(interviewTime);
         talent.setApplicationStatus("SCHEDULED");

         // Save the updated talent
         tDao_usingHibernate.update(talent);

         return ResponseEntity.ok(Map.of("success", true));
     } catch (Exception e) {
         e.printStackTrace();
         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
             .body(Map.of("success", false, "message", e.getMessage()));
     }
 }

	@GetMapping("/add")
	public String add() {
		return "formaddtalent";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute("talent") Talent talent, Model model) {
		tDao_usingHibernate.save(talent);
		model.addAttribute("talent", talent);
		return "confirmaddedtalent";
	}
	
	@GetMapping("/edit")
	public String editApplication(@RequestParam("email") String email, Model model) {
	    // Fetch Talent by email (no need to use id)
	    Talent talent = tDao_usingHibernate.findByEmail(email); 
	    model.addAttribute("talent", talent); // Add Talent object to the model
	    return "formedittalent"; // Redirect to the edit form page
	}
	
	@PostMapping("/save")
	public String saveApplication(@ModelAttribute("talent") Talent talent) {
	    // Retrieve the existing Talent from the database by email
	    Talent existingTalent = tDao_usingHibernate.findByEmail(talent.getEmail());
	    
	    if (existingTalent != null) {
	        // Update the existing Talent's details with the new data
	        existingTalent.setSchoolCode(talent.getSchoolCode());
	        existingTalent.setSchoolName(talent.getSchoolName());
	        existingTalent.setName(talent.getName());
	        existingTalent.setGender(talent.getGender());
	        existingTalent.setContact(talent.getContact());
	        existingTalent.setReason(talent.getReason());
	        // Add other fields if needed
	        
	        // Save the updated Talent object in the database
	        tDao_usingHibernate.update(existingTalent);
	    }
	    
	    // Redirect to the viewStatus page to display updated application
	    return "confirmedittalent";
	}


	@GetMapping("/delete")
	public String delete() {
		return "formdeletetalent";
	}

	@PostMapping("/delete")
	public String delete(HttpServletRequest request, Model model) {
		int id = Integer.parseInt(request.getParameter("id"));
		tDao_usingHibernate.delete(id);
		model.addAttribute("id", id);
		return "confirmdeletedtalent";
	}
	
	@GetMapping("/viewStatus")
    public String viewStatusForm() {
        return "viewStatus";  // Show the search form initially
    }
    
	@PostMapping("/viewStatus")
	public String viewStatus(@RequestParam(name = "email", required = true) String email, Model model) {
	    try {
	        if (email == null || email.trim().isEmpty()) {
	            model.addAttribute("error", "Please enter your email address");
	            return "viewStatus";
	        }
	        
	        // Find talent record by email
	        Talent talent = tDao_usingHibernate.findByEmail(email.trim());
	        
	        if (talent != null) {
	            model.addAttribute("talent", talent);
	            model.addAttribute("searched", true);
	        } else {
	            model.addAttribute("error", "No application found for this email address");
	            model.addAttribute("searched", true);
	        }
	        
	        return "viewStatus";
	        
	    } catch (Exception e) {
	        model.addAttribute("error", "An error occurred while retrieving the application status");
	        e.printStackTrace();
	        return "viewStatus";
	    }
	}

}