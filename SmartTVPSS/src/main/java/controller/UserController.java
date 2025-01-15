package controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PathVariable;


import entity.User;
import service.UserDao_usingHibernate;

@Controller
@RequestMapping("/TVPSS/user")
public class UserController {

	@Autowired
	private UserDao_usingHibernate userDao;

	// Display list of users
	@GetMapping("/userList")
	public String getUserList(@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "role", required = false) String role, Model model) {
		List<User> users = userDao.findAll();

		// Filter users based on search and role if specified
		if (search != null && !search.isEmpty()) {
			users = users.stream().filter(user -> user.getName().toLowerCase().contains(search.toLowerCase())).toList();
		}

		if (role != null && !role.isEmpty()) {
			users = users.stream().filter(user -> user.getRole().equalsIgnoreCase(role)).toList();
		}

		model.addAttribute("users", users);
		model.addAttribute("search", search);
		model.addAttribute("role", role);
		return "adminUserList";
	}

	// Show form to add a user
    @GetMapping("/add")
    public String showAddUserForm(Model model) {
        model.addAttribute("user", new User());
        return "adminUserAddForm";
    }

    // Add a user
    @PostMapping("/add")
    public String addUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        try {
            if (user.getId() == null || user.getId().isEmpty()) {
                throw new IllegalArgumentException("User ID cannot be empty!");
            }
            if (user.getRole() == null || user.getRole().isEmpty()) {
                throw new IllegalArgumentException("User role cannot be empty!");
            }
            if (user.getPassword() == null || user.getPassword().isEmpty()) {
                throw new IllegalArgumentException("Password cannot be empty!");
            }

            // Save the user
            userDao.save(user);
            redirectAttributes.addFlashAttribute("success", "User added successfully!");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", "Validation failed: " + e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to add user: " + e.getMessage());
        }
        return "redirect:/TVPSS/user/userList";
    }



	// Display success page after user is added
	@GetMapping("/userAddSuccess")
	public String showAddSuccessPage() {
		return "userAddSuccess"; // The JSP page for user add success
	}

	// Edit user form
	@GetMapping("/edit")
	public String showEditUserForm(@RequestParam("id") String id, Model model, RedirectAttributes redirectAttributes) {
		User user = userDao.findById(id);
		if (user != null) {
			model.addAttribute("user", user);
			return "adminEditUserForm";
		} else {
			redirectAttributes.addFlashAttribute("error", "User not found!");
			return "redirect:/TVPSS/user/userList";
		}
	}

	// Update user
	@PostMapping("/edit")
	public String editUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
	    try {
	        userDao.update(user.getId(), user);
	        redirectAttributes.addFlashAttribute("success", "User updated successfully!");
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("error", "Failed to update user. Please try again.");
	    }
	    return "redirect:/TVPSS/user/userList";
	}


	// Delete a user
	@GetMapping("/delete/{id}")
	public String deleteUser(@PathVariable("id") String id, RedirectAttributes redirectAttributes) {
	    try {
	        userDao.delete(id);
	        redirectAttributes.addFlashAttribute("success", "User deleted successfully!");
	    } catch (IllegalArgumentException e) {
	        redirectAttributes.addFlashAttribute("error", e.getMessage());
	    } catch (Exception e) {
	        redirectAttributes.addFlashAttribute("error", "Failed to delete user: " + e.getMessage());
	    }
	    return "redirect:/TVPSS/user/userList";
	}

}