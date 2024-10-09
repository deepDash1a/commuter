class EndPoints {
  // Base url
  static const String baseUrl = 'https://commuter.commuterscarpoling.net';


  // Authentication end points
  static const String register = '/api/register';
  static const String login = '/api/login';
  static const String forgotPassword = '/api/forgot-password';
  static const String updateProfile = '/api/profile';
  static const String getProfile = '/api/profile';
  static const String logout = '/api/logout';

  // dash board end points
  static const String messages = '/api/messages';

  // start shift end points
  static const String startShift = '/api/shift/start-store';
  static const String breakShift = '/api/shift/break';
  static const String resumeShift = '/api/shift/resume';
  static const String getAllCars = '/api/cars';

  // revenue shift end points
  static const String getAllCoursesRevenue = '/api/revenue-courses';
  static const String addShiftsRevenue = '/api/revenue-courses';
  static const String revenueTrips = '/api/revenue-trips';
  static const String addApplicationTripRevenue = '/api/revenue-applications';

  // expenses shift end points
  static const String expensesAdditional = '/api/expenses-additional';
  static const String expensesCharge = '/api/expenses-charge';
  static const String expensesFuel = '/api/expenses-fuel';

  //suppliers end points
  static const String sendNote = '/api/notes';

  //reports end points
  static const String nowDailyReport = '/api/reports/now/daily';
  static const String allDailyReport = '/api/reports/all/daily';
  static const String reportsFilter = '/api/reports/monthly';
  static const String summaryRevenue = '/api/reports/summary-revenue';
  static const String summaryExpense = '/api/reports/summary-expense';

  //suppliers end points
  static const String getAllSuppliers = '/api/suppliers';
  static const String suppliers = '/api/suppliers';

  // end shift end points
  static const String endShift = '/api/shift/end-store';
}
