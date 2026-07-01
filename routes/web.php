<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\BookingController;
use App\Http\Controllers\MembershipController;
use App\Http\Controllers\AdminController;

// Главная страница
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('/contacts', [HomeController::class, 'contacts'])->name('contacts');

// Расписание
Route::get('/schedule', [ScheduleController::class, 'index'])->name('schedule');

// Онлайн-запись
Route::get('/booking', [BookingController::class, 'index'])->name('booking');
Route::post('/booking/submit', [BookingController::class, 'submit'])->name('booking.submit');

// Абонементы
Route::get('/membership', [MembershipController::class, 'index'])->name('membership');
Route::get('/membership/buy/{id}', [MembershipController::class, 'buy'])->name('membership.buy');
Route::post('/membership/purchase/{id}', [MembershipController::class, 'purchase'])->name('membership.purchase');
Route::get('/my-memberships', [MembershipController::class, 'myMemberships'])->name('membership.my')->middleware('auth');

// Админ-панель (требует авторизации)
Route::prefix('admin')->middleware('auth')->group(function () {
    Route::get('/bookings', [AdminController::class, 'bookings'])->name('admin.bookings');
    Route::delete('/booking/{id}', [AdminController::class, 'destroy'])->name('admin.booking.delete');
});

// Статистика
Route::get('/admin/stats', [AdminController::class, 'stats'])->name('admin.stats')->middleware('auth');

// Аутентификация (ТОЛЬКО ОДИН РАЗ!)
Auth::routes();

// Диагностический маршрут
Route::get('/debug', function() {
    try {
        $tables = DB::select("SELECT name FROM sqlite_master WHERE type='table'");
        $dbExists = file_exists(database_path('database.sqlite'));
        return response()->json([
            'status' => 'ok',
            'db_file_exists' => $dbExists,
            'db_path' => database_path('database.sqlite'),
            'tables' => array_column($tables, 'name'),
            'env_debug' => env('APP_DEBUG'),
            'env_env' => env('APP_ENV'),
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'status' => 'error',
            'message' => $e->getMessage(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ], 500);
    }
});

Route::get('/test-view', function() {
    try {
        return view('home.index');
    } catch (Exception $e) {
        return $e->getMessage();
    }
});