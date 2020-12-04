package gr.athtech.toDoAppWithLogin.controller;

import gr.athtech.toDoAppWithLogin.ToDoAppWithLoginApplication;
import gr.athtech.toDoAppWithLogin.model.Item;
import gr.athtech.toDoAppWithLogin.service.InitiationService;
import gr.athtech.toDoAppWithLogin.service.ItemService;
import gr.athtech.toDoAppWithLogin.service.SessionService;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class MainController {

    SessionService sessionService;
    InitiationService initiationService;
    ItemService itemService;


    public MainController(SessionService sessionService, InitiationService initiationService, ItemService itemService) {
        this.sessionService = sessionService;
        this.initiationService = initiationService;
        this.itemService = itemService;
    }

    @GetMapping("/login")
    public String login() {
        boolean loggedIn;

        if(ToDoAppWithLoginApplication.isFirstTime()) {
            initiationService.initiateDatabase();
            ToDoAppWithLoginApplication.setFirstTime(false);
        }

        loggedIn = sessionService.isUserLoggedIn(SecurityContextHolder.getContext().getAuthentication());
        if (loggedIn) {
            /* The user is logged in */
            return "redirect:/";
        } else {
            return "login";
        }
    }

    @GetMapping("/")
    public String main(Model model) {
        List<Item> allItems = itemService.findAllItems();
        model.addAttribute("items", allItems);
        return "main";
    }

    @PostMapping("/item/add")
    public String addItem(@RequestParam String description) {
        itemService.addItem(description);
        return "redirect:/";
    }

    @PostMapping("/item/delete")
    public String deleteItem(@RequestParam long id) {
        itemService.deleteItem(id);
        return "redirect:/";
    }

    @GetMapping("/item/find")
    public String test() {
        return "test";
    }
}
