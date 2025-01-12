package controller;

import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.Activity;
import entity.Participant;
import service.ActivityDao_usingHibernate;
import service.StudentActivityDao_usingHibernate;

@Controller
@RequestMapping("/TVPSS/activity")
public class ActivityController {
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

	    return "adminActivityList";
	}

	@RequestMapping("/add1")
	@ResponseBody()
	public String add1(@ModelAttribute("activity") Activity activity) {
		aDao_usingHibernate.save(activity);
		return "adding .. " + activity.toString();
	}

	@GetMapping("/add")
	public String add() {
		return "adminAddActivity";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute("activity") Activity activity, Model model, RedirectAttributes redirectAttributes) {
		aDao_usingHibernate.save(activity);
		model.addAttribute("activity", activity);
    	redirectAttributes.addFlashAttribute("message", "Activity added successfully!");
	    return "redirect:/TVPSS/activity/activityList";
	}
	
	@GetMapping("/edit")
	public String showEditForm(@RequestParam("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
	    Activity activity = aDao_usingHibernate.findById(id);
	    if (activity == null) {
	        redirectAttributes.addFlashAttribute("error", "Activity not found!");
	        return "redirect:/TVPSS/activity/activityList";
	    }
	    model.addAttribute("startDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getStartDate()));
	    model.addAttribute("endDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getEndDate()));
	    model.addAttribute("activity", activity);
	    return "adminEditActivityForm";
	}
	
	@GetMapping("/view")
	public String viewDetails(@RequestParam("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
	    Activity activity = aDao_usingHibernate.findById(id);
	    if (activity == null) {
	        redirectAttributes.addFlashAttribute("error", "Activity not found!");
	        return "redirect:/TVPSS/activity/activityList";
	    }
	    model.addAttribute("startDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getStartDate()));
	    model.addAttribute("endDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getEndDate()));
	    model.addAttribute("activity", activity);
	    return "adminActivityDetails";
	}

	
	// Save or update the activity
	@PostMapping("/save")
	public String saveActivity(@ModelAttribute("activity") Activity activity, RedirectAttributes redirectAttributes) {
	    if (activity.getid() != null) {
	        // Update existing record
	    	aDao_usingHibernate.update(activity.getid(), activity);
	    	redirectAttributes.addFlashAttribute("message", "Activity updated successfully!");
	    } else {
	        // Add new record
	    	aDao_usingHibernate.save(activity);
	    }
	    return "redirect:/TVPSS/activity/activityList";
	}

	@GetMapping("/delete")
	public String deleteActivity(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
	    try {
	        // Check if the activity exists
	        if (aDao_usingHibernate.findById(id) == null) {
	            redirectAttributes.addFlashAttribute("error", "Activity not found!");
	        } else {
	            // Attempt to delete the activity
	            aDao_usingHibernate.delete(id);
	            redirectAttributes.addFlashAttribute("message", "Activity deleted successfully!");
	        }
	    } catch (IllegalStateException e) {
	        // Handle the case where the activity has related records
	        redirectAttributes.addFlashAttribute("error", e.getMessage());
	    } catch (Exception e) {
	        // Handle other unexpected exceptions
	        redirectAttributes.addFlashAttribute("error", "An error occurred while deleting the activity.");
	    }

	    return "redirect:/TVPSS/activity/activityList";
	}


	@RequestMapping(value = "/participant", method = RequestMethod.GET)
	public String viewParticipant(
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

	    return "adminViewParticipant";
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
	        return "redirect:/TVPSS/activity/participant";
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

	    return "adminParticipantList"; 
	}


	@GetMapping("/viewParticipantDetails")
	public String viewParticipantDetails(@RequestParam("id") Integer participantId, Model model) {
	    Participant participant = sDao_usingHibernate.findById(participantId);
	    model.addAttribute("participant", participant);
	    return "adminParticipantDetails"; 
	}

}
