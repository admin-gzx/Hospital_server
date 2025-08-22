

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PatientController {
    
    @GetMapping("/patient/test")
    public String test() {
        return "Patient service is running!";
    }
}