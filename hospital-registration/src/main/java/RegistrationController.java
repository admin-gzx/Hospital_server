

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RegistrationController {
    
    @GetMapping("/registration/test")
    public String test() {
        return "Registration service is running!";
    }
}