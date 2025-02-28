import { Component } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  credentials = { username: '', password: '' };

  constructor(private authService: AuthService, private router: Router) {}

  login() {
    this.authService.login(this.credentials).subscribe(response => {
      this.authService.saveToken(response.token);
      alert('Login successful');
      this.router.navigate(['/dashboard']); // Redirect after login
    }, error => {
      alert('Invalid credentials');
    });
  }
  forgotPassword(): void {
    // Implement forgot password functionality here
    console.log('Forgot password clicked');
  }
}
