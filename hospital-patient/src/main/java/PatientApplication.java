// 由于文件路径未体现出对应包结构，推测可能需要根据文件路径调整包声明
// 若文件路径无误，当前代码应处于默认包，移除包声明
// 移除包声明以匹配预期包

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class PatientApplication {
    public static void main(String[] args) {
        SpringApplication.run(PatientApplication.class, args);
    }
}