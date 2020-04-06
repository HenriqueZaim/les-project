package br.com.fatec.les.selenium;
// Generated by Selenium IDE
import org.junit.Test;
import org.junit.Before;
import org.junit.After;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.core.IsNot.not;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Alert;
import org.openqa.selenium.Keys;
import java.util.*;
import java.net.MalformedURLException;
import java.net.URL;

public class UserCreateTest {
  private WebDriver driver;
  private Map<String, Object> vars;
  JavascriptExecutor js;
  @Before
  public void setUp() {
    driver = new FirefoxDriver();
    js = (JavascriptExecutor) driver;
    vars = new HashMap<String, Object>();
  }
  @After
  public void tearDown() {
    driver.quit();
  }
  @Test
  public void userCreate() {
    driver.get("http://localhost:8085/schoolstore/");
    driver.manage().window().setSize(new Dimension(550, 662));
    driver.findElement(By.name("txtNome")).click();
    driver.findElement(By.name("txtNome")).sendKeys("Henrique Zaim");
    driver.findElement(By.name("txtNumeroTelefone")).sendKeys("11974056533");
    driver.findElement(By.name("txtNumeroDocumento")).sendKeys("0123456789");
    driver.findElement(By.id("file")).sendKeys("/home/henrique/Imagens/logo.svg");
    driver.findElement(By.id("button")).click();
    driver.findElement(By.name("txtEmail")).click();
    driver.findElement(By.name("txtEmail")).sendKeys("henrique@gmail.com");
    driver.findElement(By.name("txtSenha")).sendKeys("qwer1234");
    driver.findElement(By.name("txtLogradouro")).sendKeys("Rua Antonio");
    driver.findElement(By.name("txtBairro")).sendKeys("Mogilar");
    driver.findElement(By.name("txtNumero")).sendKeys("110");
    driver.findElement(By.name("txtComplemento")).sendKeys("bloco 19");
    driver.findElement(By.name("txtReferencia")).sendKeys("fatec");
    driver.findElement(By.name("txtCep")).sendKeys("08773495");
    driver.findElement(By.name("txtFavorito")).click();
    driver.findElement(By.cssSelector("input:nth-child(36)")).click();
  }
}
