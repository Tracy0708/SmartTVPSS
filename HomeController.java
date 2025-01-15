package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.User;
import service.HomeDao_usingHibernate;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    private HomeDao_usingHibernate HomeDao;

    // Display login form
    @GetMapping("/login")
    public String showLoginForm() {
        return "login"; // Return the login view
    }

    // Process login form
    @PostMapping("/login")
    public String processLogin(@RequestParam("email") String email,
                                @RequestParam("password") String password,
                                RedirectAttributes redirectAttributes) {
        User user = HomeDao.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            switch (user.getRole()) {
                case "TVPSS Management":
                    return "redirect:/home/TVPSS/dashboard";
                case "School Administrator":
                    return "redirect:/home/admin/dashboard";
                case "Student":
                    return "redirect:/home/student/dashboard";
                default:
                    redirectAttributes.addFlashAttribute("error", "Role not recognized.");
                    return "redirect:/home/login";
            }
        }
        redirectAttributes.addFlashAttribute("error", "Invalid email or password.");
        return "redirect:/home/login";
    }

    // Display signup form
    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        model.addAttribute("user", new User());
        return "signup"; // Return the signup view
    }

    // Process signup form
    @PostMapping("/signup")
    public String processSignup(@ModelAttribute("user") User user,
                                 RedirectAttributes redirectAttributes) {
        if (HomeDao.findByEmail(user.getEmail()) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already exists.");
            return "redirect:/home/signup";
        }

        if (user.getId().startsWith("A")) {
            user.setRole("TVPSS Management");
        } else if (user.getId().startsWith("B")) {
            user.setRole("School Administrator");
        } else if (user.getId().startsWith("C")) {
            user.setRole("Student");
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid ID format.");
            return "redirect:/home/signup";
        }

        HomeDao.save(user);
        redirectAttributes.addFlashAttribute("success", "Signup successful! You can now log in.");
        return "redirect:/home/signup"; // Redirect back to signup page to display success
    }

    // Display TVPSS Management dashboard
    @GetMapping("/TVPSS/dashboard")
    public String showManagementDashboard() {
        return "tvpss_dashboard"; // Return the management dashboard view
    }

    // Display School Administrator dashboard
    @GetMapping("/admin/dashboard")
    public String showAdminDashboard() {
        return "admin_dashboard"; // Return the admin dashboard view
    }

    // Display Student dashboard
    @GetMapping("/student/dashboard")
    public String showStudentDashboard() {
        return "student_dashboard"; // Return the student dashboard view
    }
    
 // Display forgot password form
    @GetMapping("/forgotpassword")
    public String showForgotPasswordForm(Model model) {
        model.addAttribute("email", ""); // Initialize an empty email field
        return "forgot_password"; // Return the forgot password view
    }

 // Process forgot password form
    @PostMapping("/forgotpassword")
    public String verifyEmail(@RequestParam("email") String email,
                              RedirectAttributes redirectAttributes,
                              Model model) {
        User user = HomeDao.findByEmail(email);
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "No account found with this email address.");
            return "redirect:/home/forgotpassword";
        }

        model.addAttribute("verifiedEmail", email);
        return "forgot_password"; // Return the forgot password page with the email verified
    }

    @PostMapping("/resetpassword")
    public String resetPassword(@RequestParam("email") String email,
                                @RequestParam("newPassword") String newPassword,
                                @RequestParam("confirmPassword") String confirmPassword,
                                RedirectAttributes redirectAttributes) {
        System.out.println("Starting password reset for email: " + email);

        if (!newPassword.equals(confirmPassword)) {
            System.out.println("Passwords do not match.");
            redirectAttributes.addFlashAttribute("error", "Passwords do not match.");
            redirectAttributes.addFlashAttribute("verifiedEmail", email);
            return "redirect:/home/forgotpassword";
        }

        User user = HomeDao.findByEmail(email);
        if (user == null) {
            System.out.println("No account found for email: " + email);
            redirectAttributes.addFlashAttribute("error", "No account found with this email address.");
            return "redirect:/home/forgotpassword";
        }

        try {
            System.out.println("Updating password for user: " + user.getId());
            user.setPassword(newPassword); // Update the password
            HomeDao.save(user); // Save the updated user
            System.out.println("Password updated successfully for user: " + user.getId());
            redirectAttributes.addFlashAttribute("success", "Password reset successful! You can now log in.");
            return "redirect:/home/login";
        } catch (Exception e) {
            System.out.println("Error occurred while resetting password: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "An error occurred while resetting the password. Please try again.");
            return "redirect:/home/forgotpassword";
        }
    }

}
