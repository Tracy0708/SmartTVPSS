package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Activity;
import entity.Participant;
import service.ActivityDao_usingHibernate;
import service.StudentActivityDao_usingHibernate;

@Controller
@RequestMapping("/admin/activity")
public class AdminActivityController {
	@Autowired // spring dependency injection
	private ActivityDao_usingHibernate aDao_usingHibernate;
		
	@Autowired
	private StudentActivityDao_usingHibernate sDao_usingHibernate;
	

	@RequestMapping(value = "/activityList", method = RequestMethod.GET)
	public String listActivities(
	    @RequestParam(value = "search", required = false) String search,
	    @RequestParam(value = "type", required = false) String type,
	    @RequestParam(value = "level", required = false) String level,
	    @RequestParam(value = "page", defaultValue = "1") int page,
	    Model model) {

	    // Set default values for filters if null
	    if (search == null) search = "";
	    if (type == null) type = "";
	    if (level == null) level = "";

	    int pageSize = 10;
	    List<Activity> activities = aDao_usingHibernate.getOngoingActivities(search, type, level, page, pageSize);
	    int totalActivities = aDao_usingHibernate.getOngoingActivitiesCount(search, type, level);

	    int totalPages = (int) Math.ceil((double) totalActivities / pageSize);

	    model.addAttribute("activities", activities);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    

	    return "schoolActivityList";
	}
	
	
	@GetMapping("/edit")
	public String showEditForm(@RequestParam("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
	    Participant participant = sDao_usingHibernate.findById(id);
	    if (participant == null) {
	        redirectAttributes.addFlashAttribute("error", "Participant not found!");
	        return "redirect:/admin/activity/viewParticipant?id=${id}";
	    }
	    
	    model.addAttribute("participant", participant);
	    return "schoolEditParticipantForm";
	}
	
	// Save or update the activity
		@PostMapping("/save")
		public String saveParticipant(@ModelAttribute("participant") Participant participant, RedirectAttributes redirectAttributes) {
		    if (participant.getParticipant_id() != null) {
		        // Update existing record
		    	sDao_usingHibernate.update(participant.getParticipant_id(), participant);
		    	redirectAttributes.addFlashAttribute("message", "Participant updated successfully!");
		    } else {
		        // Add new record
		    	sDao_usingHibernate.save(participant);
		    	redirectAttributes.addFlashAttribute("message", "Participant added successfully!");
		    }
		    return "redirect:/admin/activity/viewParticipant?id=" + participant.getActivityId();

		}

		@GetMapping("/delete")
		public String deleteParticipant(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
		    Participant participant = sDao_usingHibernate.findById(id);
		    if (participant == null) {
		        redirectAttributes.addFlashAttribute("error", "Participant not found!");
		    } else {
		        try {
		            // Delete the participant
		            sDao_usingHibernate.delete(id);

		            redirectAttributes.addFlashAttribute("message", "Participant deleted successfully!");
		        } catch (Exception e) {
		            redirectAttributes.addFlashAttribute("error", "Failed to delete participant. Error: " + e.getMessage());
		        }
		    }
		    return "redirect:/admin/activity/viewParticipant?id=" + participant.getActivityId();
		}

		@GetMapping("/viewParticipant")
		public String viewParticipants(
		    @RequestParam("id") Integer activityId,
		    @RequestParam(value = "search", defaultValue = "") String search,
		    @RequestParam(value = "gender", defaultValue = "") String gender,
		    @RequestParam(value = "page", defaultValue = "1") int page,
		    @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
		    Model model,
		    RedirectAttributes redirectAttributes
		) {
		    // Retrieve the activity
		    Activity activity = aDao_usingHibernate.findById(activityId);
		    if (activity == null) {
		        redirectAttributes.addFlashAttribute("error", "Activity not found!");
		        return "redirect:/admin/activity/participant";
		    }

		    // Check if any filters are applied
		    boolean isFilterApplied = !(search.isEmpty() && gender.isEmpty());

		    List<Participant> participants;
		    int totalParticipants;

		    if (isFilterApplied) {
		        // Retrieve filtered participants
		        participants = sDao_usingHibernate.getFilteredParticipant(activityId, search, gender, page, pageSize);
		        totalParticipants = sDao_usingHibernate.getFilteredParticipantCount(activityId, search, gender);
		    } else {
		        // Retrieve all participants for the activity
		        participants = sDao_usingHibernate.findParticipantsByActivityId(activityId);
		        totalParticipants = participants.size();
		    }

		    int totalPages = (int) Math.ceil((double) totalParticipants / pageSize);

		    // Add data to the model
		    model.addAttribute("activity", activity);
		    model.addAttribute("participants", participants);
		    model.addAttribute("currentPage", page);
		    model.addAttribute("totalPages", totalPages);
		    model.addAttribute("search", search);
		    model.addAttribute("gender", gender);

		    return "schoolParticipantList"; // JSP file
		}

}