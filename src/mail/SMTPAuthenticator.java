package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.*;

public class SMTPAuthenticator extends Authenticator
{

    @Override
    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("na_falen","qpal594561");
    }
}