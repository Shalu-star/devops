import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
//import org.openqa.selenium.edge.EdgeDriver;
//import org.openqa.selenium.firefox.FirefoxDriver;

public class SeleniumIntroduction {

	public static void main(String[] args) {
		
		//Invoking Browser
		//Chrome - ChromeDriver exten->Methods close get
		//Firefox- FirefoxDriver ->methods close get
		// WebDriver  close  get
		//WebDriver methods + class methods
		// Chrome
		         ChromeOptions options = new ChromeOptions();
		         options.addArguments("--remote-allow-origins=*");
		System.setProperty("webdriver.chrome.driver", "C:\\Users\\sgupt187\\Desktop\\QA Training\\AutomationTraining\\SeleniumWithJava\\drivers\\chromedriver.exe");
		WebDriver driver = new ChromeDriver(options);
		driver.get("https://www.w3schools.com/");
		System.out.println(driver.getTitle());
		System.out.println(driver.getCurrentUrl());
		driver.close();
		//driver.quit();
		
		
		//Firefox
//		System.setProperty("webdriver.gecko.driver", "/Users/rahulshetty/Documents/geckodriver");
//		WebDriver driver1 = new FirefoxDriver();
//		
//		driver1.get("https://www.w3schools.com/");
//		System.out.println(driver1.getTitle());
//		System.out.println(driver1.getCurrentUrl());
		//driver.close();
	
		//Microsoft Edge
		// System.setProperty("webdriver.edge.driver", "C:\\Users\\sgupt187\\Desktop\\QA Training\\AutomationTraining\\SeleniumWithJava\\drivers\\msedgedriver.exe");
		// WebDriver driver1 = new EdgeDriver();
		// driver1.get("https://www.w3schools.com/");
		// System.out.println(driver1.getTitle());
		// System.out.println(driver1.getCurrentUrl());
		



	}

}
