package controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@PostMapping(value = "/admin/talentList", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
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

	@GetMapping("/admin/delete")
	public String deleteTalent(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		try {
			// Check if the activity exists
			if (tDao_usingHibernate.findById(id) == null) {
				redirectAttributes.addFlashAttribute("error", "Talent not found!");
			} else {
				// Attempt to delete the activity
				tDao_usingHibernate.delete(id);
				redirectAttributes.addFlashAttribute("message", "Talent deleted successfully!");
			}
		} catch (IllegalStateException e) {
			// Handle the case where the activity has related records
			redirectAttributes.addFlashAttribute("error", e.getMessage());
		} catch (Exception e) {
			// Handle other unexpected exceptions
			redirectAttributes.addFlashAttribute("error", "An error occurred while deleting the Talent.");
		}

		return "redirect:/talent/admin/talentList";
	}
	
	@PostMapping("/admin/updateStatus")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateStatus(@RequestBody Map<String, Object> request) {
	    try {
	        // Retrieve and parse values from the request map
	        Object idObj = request.get("id");
	        Object statusObj = request.get("status");

	        // Validate the presence of id and status
	        if (idObj == null || statusObj == null) {
	            Map<String, Object> errorResponse = new HashMap<>();
	            errorResponse.put("success", false);
	            errorResponse.put("message", "ID and status are required.");
	            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
	        }

	        int id = Integer.parseInt(idObj.toString());  // Corrected casting
	        String status = statusObj.toString();

	        // Update talent status
	        tDao_usingHibernate.updateTalentStatus(id, status);

	        // Success response
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", true);
	        response.put("message", "Status updated successfully.");
	        return ResponseEntity.ok(response);
	    } catch (NumberFormatException e) {
	        // Handle invalid integer format for ID
	        Map<String, Object> errorResponse = new HashMap<>();
	        errorResponse.put("success", false);
	        errorResponse.put("message", "Invalid ID format.");
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
	    } catch (Exception e) {
	        // Handle other exceptions
	        Map<String, Object> errorResponse = new HashMap<>();
	        errorResponse.put("success", false);
	        errorResponse.put("message", "Failed to update status: " + e.getMessage());
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
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

	@GetMapping("/viewStatus")
	public String viewStatusForm() {
		return "viewStatus"; // Show the search form initially
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