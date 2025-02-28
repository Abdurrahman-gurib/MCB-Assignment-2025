import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FormsModule } from '@angular/forms';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { RouterTestingModule } from '@angular/router/testing';
import { LoginComponent } from './login.component';
import { AuthService } from '../../services/auth.service';
import { of, throwError } from 'rxjs';

describe('LoginComponent', () => {
  let component: LoginComponent;
  let fixture: ComponentFixture<LoginComponent>;
  let authService: AuthService;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [FormsModule, HttpClientTestingModule, RouterTestingModule],
      declarations: [LoginComponent],
      providers: [AuthService]
    })
    .compileComponents();

    fixture = TestBed.createComponent(LoginComponent);
    component = fixture.componentInstance;
    authService = TestBed.inject(AuthService);
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should call login method on form submit', () => {
    spyOn(component, 'login');
    const form = fixture.nativeElement.querySelector('form');
    form.dispatchEvent(new Event('submit'));
    expect(component.login).toHaveBeenCalled();
  });

  it('should login successfully', () => {
    const credentials = { username: 'test', password: 'test' };
    component.credentials = credentials;
    spyOn(authService, 'login').and.returnValue(of({ token: '12345' }));
    spyOn(authService, 'saveToken');
    spyOn(window, 'alert');
    spyOn(component['router'], 'navigate');

    component.login();

    expect(authService.login).toHaveBeenCalledWith(credentials);
    expect(authService.saveToken).toHaveBeenCalledWith('12345');
    expect(window.alert).toHaveBeenCalledWith('Login successful');
    expect(component['router'].navigate).toHaveBeenCalledWith(['/dashboard']);
  });

  it('should show error on login failure', () => {
    const credentials = { username: 'test', password: 'wrong' };
    component.credentials = credentials;
    spyOn(authService, 'login').and.returnValue(throwError({ status: 401 }));
    spyOn(window, 'alert');

    component.login();

    expect(authService.login).toHaveBeenCalledWith(credentials);
    expect(window.alert).toHaveBeenCalledWith('Invalid credentials');
  });

  it('should call forgotPassword method when forgot password link is clicked', () => {
    spyOn(component, 'forgotPassword');
    const forgotPasswordLink = fixture.nativeElement.querySelector('a');
    forgotPasswordLink.click();
    expect(component.forgotPassword).toHaveBeenCalled();
  });
});
