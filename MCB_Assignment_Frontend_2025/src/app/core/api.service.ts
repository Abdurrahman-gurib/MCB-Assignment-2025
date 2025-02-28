import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private baseUrl = 'http://localhost:5085/api/Migration'; // adjust if needed

  constructor(private http: HttpClient) { }

  getSuppliers(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/suppliers`);
  }

  getOrders(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/orders`);
  }

  getInvoices(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}/invoices`);
  }

  // New Methods for additional API endpoints

  // Fetch Median Order Data
  getMedianOrder(): Observable<any[]> {
    return this.http.get<any[]>(`http://localhost:5085/api/MedianOrder`);
  }

  // Fetch Order Management Data
  getOrderManagement(): Observable<any[]> {
    return this.http.get<any[]>(`http://localhost:5085/api/OrderManagement`);
  }

  // Fetch Orders Report Data
  getOrdersReport(): Observable<any[]> {
    return this.http.get<any[]>(`http://localhost:5085/api/Report/orders`);
  }

  // Fetch Supplier Orders Summary
  getSupplierOrdersSummary(): Observable<any[]> {
    return this.http.get<any[]>(`http://localhost:5085/api/SupplierOrders/summary`);
  }
}
