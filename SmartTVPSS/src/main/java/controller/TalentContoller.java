package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import entity.Talent;
import service.TalentDao_usingHibernate;

@Controller
@RequestMapping("/talent")
public class TalentContoller {
	@Autowired // spring dependency injection
	private TalentDao_usingHibernate tDao_usingHibernate;

	@RequestMapping("/talentList")
	public String getAllCustomers(Model model) {
		List<Talent> talentList = tDao_usingHibernate.findAll();
		model.addAttribute("talentList", talentList);
		return "talentList";
	}

	@RequestMapping("/add1")
	@ResponseBody()
	public String add1(@ModelAttribute("talent") Talent talent) {
		tDao_usingHibernate.save(talent);
		return "adding .. " + talent.toString();
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
}
