import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class WindowActivity {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
	       ChromeOptions options = new ChromeOptions();
	        options.addArguments("--remote-allow-origins=*");
			System.setProperty("webdriver.chrome.driver", "C:\\Users\\sgupt187\\Desktop\\QA Training\\AutomationTraining\\SeleniumWithJava\\drivers\\chromedriver.exe");
			WebDriver driver = new ChromeDriver(options);
		
		driver.manage().window().maximize();
		driver.get("http://google.com");
		driver.navigate().to("https://rahulshettyacademy.com");
		driver.navigate().back();
		driver.navigate().forward();


	}

}
