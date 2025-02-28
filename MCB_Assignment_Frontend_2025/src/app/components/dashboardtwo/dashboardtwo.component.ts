import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ApiService } from '../../core/api.service';

@Component({
  selector: 'app-dashboardtwo',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './dashboardtwo.component.html',
  styleUrls: ['./dashboardtwo.component.css']
})
export class DashboardtwoComponent implements OnInit {
  medianOrders: any[] = [];
  orderManagement: any[] = [];
  ordersReport: any[] = [];
  supplierOrdersSummary: any[] = [];
  errorMessage: string = '';

  constructor(private apiService: ApiService, private cdr: ChangeDetectorRef) { }

  ngOnInit() {
    this.loadMedianOrders();
    // this.loadOrderManagement();
    this.loadOrdersReport();
    this.loadSupplierOrdersSummary();
  }

  loadMedianOrders() {
    this.apiService.getMedianOrder().subscribe({
      next: (data) => {
        console.log('Median Orders:', data);
        // Convert the single object response to an array
        this.medianOrders = data ? [data] : [];
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Error loading median orders:', err);
        this.errorMessage = 'Error loading median orders';
      }
    });
  }

  // loadOrderManagement() {
  //   this.apiService.getOrderManagement().subscribe({
  //     next: (data) => {
  //       console.log('Order Management:', data);
  //       // Assign the array response directly to orderManagement
  //       this.orderManagement = data || [];
  //       this.cdr.detectChanges();
  //     },
  //     error: (err) => {
  //       console.error('Error loading order management:', err);
  //       this.errorMessage = 'Error loading order management';
  //     }
  //   });
  // }

  loadOrdersReport() {
    this.apiService.getOrdersReport().subscribe({
      next: (data) => {
        console.log('Orders Report:', data);
        // Assign the array response directly to ordersReport
        this.ordersReport = data || [];
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
        console.log('Supplier Orders Summary:', data);
        // Assign the array response directly to supplierOrdersSummary
        this.supplierOrdersSummary = data || [];
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
