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
import service.ActivityDao_usingHibernate;

@Controller
@RequestMapping("/activity")
public class ActivityController {
	@Autowired // spring dependency injection
	private ActivityDao_usingHibernate aDao_usingHibernate;
	

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

	    return "activityList";
	}

	@RequestMapping("/add1")
	@ResponseBody()
	public String add1(@ModelAttribute("activity") Activity activity) {
		aDao_usingHibernate.save(activity);
		return "adding .. " + activity.toString();
	}

	@GetMapping("/add")
	public String add() {
		return "addActivity";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute("activity") Activity activity, Model model, RedirectAttributes redirectAttributes) {
		aDao_usingHibernate.save(activity);
		model.addAttribute("activity", activity);
    	redirectAttributes.addFlashAttribute("message", "Activity added successfully!");
	    return "redirect:/activity/activityList";
	}
	
	@GetMapping("/edit")
	public String showEditForm(@RequestParam("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
	    Activity activity = aDao_usingHibernate.findById(id);
	    if (activity == null) {
	        redirectAttributes.addFlashAttribute("error", "Activity not found!");
	        return "redirect:/activity/activityList";
	    }
	    model.addAttribute("startDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getStartDate()));
	    model.addAttribute("endDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getEndDate()));
	    model.addAttribute("activity", activity);
	    return "editActivityForm";
	}
	
	@GetMapping("/view")
	public String viewDetails(@RequestParam("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
	    Activity activity = aDao_usingHibernate.findById(id);
	    if (activity == null) {
	        redirectAttributes.addFlashAttribute("error", "Activity not found!");
	        return "redirect:/activity/activityList";
	    }
	    model.addAttribute("startDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getStartDate()));
	    model.addAttribute("endDateFormatted", new SimpleDateFormat("yyyy-MM-dd").format(activity.getEndDate()));
	    model.addAttribute("activity", activity);
	    return "viewDetails";
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
	    return "redirect:/activity/activityList";
	}

	@GetMapping("/delete")
	public String deleteActivity(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
	    if (aDao_usingHibernate.findById(id) == null) {
	        redirectAttributes.addFlashAttribute("error", "Activity not found!");
	    } else {
	        aDao_usingHibernate.delete(id);
	        redirectAttributes.addFlashAttribute("message", "Activity deleted successfully!");
	    }
	    return "redirect:/activity/activityList";
	}

}
