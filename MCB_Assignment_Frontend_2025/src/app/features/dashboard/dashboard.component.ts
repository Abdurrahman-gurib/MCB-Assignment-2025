import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../core/api.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {
  suppliers: any[] = [];
  orders: any[] = [];
  invoices: any[] = [];
  medianOrders: any[] = [];
  orderManagement: any[] = [];
  ordersReport: any[] = [];
  supplierOrdersSummary: any[] = [];
  errorMessage: string = '';

  constructor(private apiService: ApiService, private cdr: ChangeDetectorRef) { }

  ngOnInit() {
    this.loadSuppliers();
    this.loadOrders();
    this.loadInvoices();
    this.loadMedianOrders();
    this.loadOrderManagement();
    this.loadOrdersReport();
    this.loadSupplierOrdersSummary();
  }

  loadSuppliers() {
    this.apiService.getSuppliers().subscribe({
      next: (data) => {
        console.log('Suppliers:', data);
        this.suppliers = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading suppliers:', err);
        this.errorMessage = 'Error loading suppliers';
      }
    });
  }

  loadOrders() {
    this.apiService.getOrders().subscribe({
      next: (data) => {
        console.log('Orders:', data);
        this.orders = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading orders:', err);
        this.errorMessage = 'Error loading orders';
      }
    });
  }

  loadInvoices() {
    this.apiService.getInvoices().subscribe({
      next: (data) => {
        console.log('Invoices:', data);
        this.invoices = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading invoices:', err);
        this.errorMessage = 'Error loading invoices';
      }
    });
  }

  loadMedianOrders() {
    this.apiService.getMedianOrder().subscribe({
      next: (data) => {
        console.log('Median Orders:', data); // Add this line
        this.medianOrders = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading median orders:', err);
        this.errorMessage = 'Error loading median orders';
      }
    });
  }

  loadOrderManagement() {
    this.apiService.getOrderManagement().subscribe({
      next: (data) => {
        console.log('Order Management:', data); // Add this line
        this.orderManagement = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading order management:', err);
        this.errorMessage = 'Error loading order management';
      }
    });
  }

  loadOrdersReport() {
    this.apiService.getOrdersReport().subscribe({
      next: (data) => {
        console.log('Orders Report:', data); // Add this line
        this.ordersReport = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading orders report:', err);
        this.errorMessage = 'Error loading orders report';
      }
    });
  }

  loadSupplierOrdersSummary() {
    this.apiService.getSupplierOrdersSummary().subscribe({
      next: (data) => {
        console.log('Supplier Orders Summary:', data); // Add this line
        this.supplierOrdersSummary = data;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading supplier orders summary:', err);
        this.errorMessage = 'Error loading supplier orders summary';
      }
    });
  }

  /**
   * Helper method to display a value. If the value is an object or falsy,
   * it returns a dash. Otherwise, it returns the value.
   */
  displayValue(value: any): string {
    // If value is null, undefined, or an object, return dash.
    if (!value || typeof value === 'object') {
      return '-';
    }
    return value;
  }
}
