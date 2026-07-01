<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Booking;
use Illuminate\Support\Facades\DB;

class AdminController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth');
    }
    
    // Список всех записей на тренировки
    public function bookings()
    {
        $bookings = Booking::orderBy('created_at', 'desc')->get();
        return view('admin.bookings', compact('bookings'));
    }
    
    // Удаление записи
    public function destroy($id)
    {
        $booking = Booking::findOrFail($id);
        $booking->delete();
        
        return redirect()->route('admin.bookings')->with('success', 'Запись удалена');
    }
    
    // Статистика продаж (напрямую из таблиц purchases и memberships)
    public function stats()
    {
        $stats = DB::table('memberships')
            ->leftJoin('purchases', function ($join) {
                $join->on('memberships.id', '=', 'purchases.membership_id')
                     ->where('purchases.status', '=', 'paid');
            })
            ->select(
                'memberships.name as membership_name',
                DB::raw('COUNT(purchases.id) as total_sold'),
                DB::raw('COALESCE(SUM(purchases.price), 0) as total_revenue'),
                DB::raw('COALESCE(AVG(purchases.price), 0) as average_price')
            )
            ->groupBy('memberships.id', 'memberships.name')
            ->orderBy('total_sold', 'DESC')
            ->get();

        return view('admin.stats', compact('stats'));
    }
}
