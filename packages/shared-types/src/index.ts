// Shared types that can be used by both Flutter and Node.js applications

export interface User {
  id: string;
  email: string;
  name: string;
  createdAt: Date;
}

export interface Spot {
  id: string;
  name: string;
  description: string;
  latitude: number;
  longitude: number;
  createdBy: string;
  createdAt: Date;
}

export interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: string;
  message?: string;
}

export interface PaginatedResponse<T> {
  data: T[];
  total: number;
  page: number;
  limit: number;
  hasNext: boolean;
  hasPrev: boolean;
}
