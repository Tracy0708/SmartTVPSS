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
@RequestMapping("/student/activity")
public class StudentActivityController {
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
	    List<Activity> activities = aDao_usingHibernate.getFilteredActivities(search, type, level, page, pageSize);
	    int totalActivities = aDao_usingHibernate.getFilteredActivitiesCount(search, type, level);

	    int totalPages = (int) Math.ceil((double) totalActivities / pageSize);

	    model.addAttribute("activities", activities);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);
	    

	    return "studentActivityList";
	}
	
	@GetMapping("/register")
	public String showRegisterForm(@RequestParam("id") Integer id, Model model) {
	    Activity activity = aDao_usingHibernate.findById(id);
	    if (activity == null) {
	        model.addAttribute("error", "Activity not found.");
	        return "redirect:/student/activity/activityList";
	    }

	    model.addAttribute("activity", activity);
	    model.addAttribute("participant", new Participant());
	    return "studentRegisterParticipantForm";
	}

	
	@PostMapping("/register")
	public String registerParticipant(@ModelAttribute("participant") Participant participant,
	                                  @RequestParam(value = "activityId", required = true) Integer activityId,
	                                  RedirectAttributes redirectAttributes) {

	    participant.setActivityId(activityId);
	    
	    String result = sDao_usingHibernate.save(participant);
	    if (result.equals("Participant limit reached for this activity.")) {
	        redirectAttributes.addFlashAttribute("error", result);
	        return "redirect:/student/activity/register?id=" + activityId;
	    }
	    
        redirectAttributes.addFlashAttribute("message", result);
	    return "redirect:/student/activity/activityList";
	}
}