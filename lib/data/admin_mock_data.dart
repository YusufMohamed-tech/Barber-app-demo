import '../models/admin_barber_model.dart';
import '../models/admin_booking_model.dart';
import '../models/admin_client_model.dart';
import '../models/admin_service_model.dart';

class AdminMockData {
  const AdminMockData._();

  static const barberImages = [
    'https://images.unsplash.com/photo-1618077360395-f3068be8e001?auto=format&fit=crop&w=500&q=85',
    'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=500&q=85',
    'https://images.unsplash.com/photo-1615109398623-88346a601842?auto=format&fit=crop&w=500&q=85',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=85',
  ];

  static const barbers = <AdminBarberModel>[
    AdminBarberModel(
      id: 'a1',
      name: 'أحمد المصري',
      specialty: 'حلاقة كلاسيكية',
      phone: '010 1234 5678',
      imageUrl:
          'https://images.unsplash.com/photo-1618077360395-f3068be8e001?auto=format&fit=crop&w=500&q=85',
      rating: 4.8,
      status: 'نشط',
      bio:
          'خبير حلاقة بخبرة تزيد عن 6 سنوات في جميع أنواع الحلاقة الكلاسيكية والحديثة.',
    ),
    AdminBarberModel(
      id: 'a2',
      name: 'محمد محمود',
      specialty: 'حلاقة حديثة',
      phone: '010 9876 5432',
      imageUrl:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=500&q=85',
      rating: 4.6,
      status: 'نشط',
      bio: 'متخصص في القصات العصرية والتدرجات الدقيقة وتجهيز العريس.',
    ),
    AdminBarberModel(
      id: 'a3',
      name: 'علي رضا',
      specialty: 'تهذيب شعر',
      phone: '010 1122 3344',
      imageUrl:
          'https://images.unsplash.com/photo-1615109398623-88346a601842?auto=format&fit=crop&w=500&q=85',
      rating: 4.7,
      status: 'نشط',
      bio: 'يهتم بتفاصيل الشعر واللحية ويقدم استشارة مظهر كاملة.',
    ),
    AdminBarberModel(
      id: 'a4',
      name: 'كريم أحمد',
      specialty: 'حلاقة أطفال',
      phone: '010 5566 7788',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=85',
      rating: 4.4,
      status: 'غير نشط',
      bio: 'حلاق هادئ ومناسب لتجربة الأطفال والقصات السريعة.',
    ),
    AdminBarberModel(
      id: 'a5',
      name: 'يوسف خالد',
      specialty: 'حلاقة شعر',
      phone: '012 3456 7890',
      imageUrl:
          'https://images.unsplash.com/photo-1607346256330-dee7af15f7c5?auto=format&fit=crop&w=500&q=85',
      rating: 4.5,
      status: 'نشط',
      bio: 'متخصص في الحلاقة اليومية والتصفيف العملي الأنيق.',
    ),
    AdminBarberModel(
      id: 'a6',
      name: 'يوسف جمال',
      specialty: 'تهذيب وتصفيف',
      phone: '011 2222 3333',
      imageUrl:
          'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?auto=format&fit=crop&w=500&q=85',
      rating: 4.3,
      status: 'غير نشط',
      bio: 'يقدم خدمات التصفيف واللمسات النهائية للمناسبات.',
    ),
  ];

  static const services = <AdminServiceModel>[
    AdminServiceModel(
      id: 's1',
      name: 'حلاقة كلاسيكية',
      category: 'حلاقة',
      description: 'حلاقة مرتبة بتفاصيل كلاسيكية وغسل خفيف.',
      duration: '30 دقيقة',
      price: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1622286346003-c8d5d47b176f?auto=format&fit=crop&w=600&q=85',
    ),
    AdminServiceModel(
      id: 's2',
      name: 'حلاقة حديثة',
      category: 'حلاقة',
      description: 'قصة عصرية مع تدرج احترافي وتصفيف نهائي.',
      duration: '45 دقيقة',
      price: 150,
      imageUrl:
          'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?auto=format&fit=crop&w=600&q=85',
    ),
    AdminServiceModel(
      id: 's3',
      name: 'حلاقة + لحية',
      category: 'حلاقة',
      description: 'حلاقة شعر كاملة مع تحديد وتهذيب اللحية.',
      duration: '60 دقيقة',
      price: 200,
      imageUrl:
          'https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=600&q=85',
    ),
    AdminServiceModel(
      id: 's4',
      name: 'تنظيف بشرة',
      category: 'عناية',
      description: 'تنظيف لطيف للبشرة وإزالة الشوائب.',
      duration: '40 دقيقة',
      price: 180,
      imageUrl:
          'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?auto=format&fit=crop&w=600&q=85',
    ),
    AdminServiceModel(
      id: 's5',
      name: 'صبغ شعر',
      category: 'عناية',
      description: 'تلوين احترافي مع اختيار الدرجة المناسبة.',
      duration: '50 دقيقة',
      price: 250,
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=600&q=85',
    ),
    AdminServiceModel(
      id: 's6',
      name: 'تهذيب اللحية',
      category: 'لحية',
      description: 'تحديد وتهذيب اللحية بأدوات معقمة.',
      duration: '25 دقيقة',
      price: 80,
      imageUrl:
          'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?auto=format&fit=crop&w=600&q=85',
    ),
  ];

  static const bookings = <AdminBookingModel>[
    AdminBookingModel(
      id: 'b1',
      clientName: 'محمد أحمد',
      clientPhone: '010 9876 5432',
      serviceName: 'حلاقة كلاسيكية',
      barberName: 'أحمد المصري',
      date: '24 مايو 2025',
      time: '11:00 ص',
      duration: '30 دقيقة',
      price: 120,
      paymentMethod: 'الدفع في المحل',
      notes: 'لا توجد ملاحظات',
      status: 'مؤكد',
    ),
    AdminBookingModel(
      id: 'b2',
      clientName: 'علي محمود',
      clientPhone: '011 2345 6789',
      serviceName: 'حلاقة حديثة',
      barberName: 'محمد محمود',
      date: '24 مايو 2025',
      time: '01:30 م',
      duration: '45 دقيقة',
      price: 150,
      paymentMethod: 'الدفع في المحل',
      notes: 'يريد تدرج خفيف',
      status: 'مؤكد',
    ),
    AdminBookingModel(
      id: 'b3',
      clientName: 'كريم رمضان',
      clientPhone: '010 1111 2222',
      serviceName: 'تنظيف بشرة',
      barberName: 'علي رضا',
      date: '24 مايو 2025',
      time: '03:00 م',
      duration: '40 دقيقة',
      price: 180,
      paymentMethod: 'بطاقة بنكية',
      notes: 'بشرة حساسة',
      status: 'منتهي',
    ),
    AdminBookingModel(
      id: 'b4',
      clientName: 'يوسف خالد',
      clientPhone: '012 3456 7890',
      serviceName: 'حلاقة لحية',
      barberName: 'كريم أحمد',
      date: '24 مايو 2025',
      time: '04:30 م',
      duration: '25 دقيقة',
      price: 80,
      paymentMethod: 'الدفع في المحل',
      notes: 'لا توجد ملاحظات',
      status: 'ملغي',
    ),
    AdminBookingModel(
      id: 'b5',
      clientName: 'أحمد علاء',
      clientPhone: '010 2222 3333',
      serviceName: 'حلاقة + لحية',
      barberName: 'أحمد المصري',
      date: '24 مايو 2025',
      time: '06:00 م',
      duration: '60 دقيقة',
      price: 200,
      paymentMethod: 'محفظة إلكترونية',
      notes: 'تجهيز سريع',
      status: 'مؤكد',
    ),
  ];

  static const clients = <AdminClientModel>[
    AdminClientModel(
      id: 'c1',
      name: 'محمد أحمد',
      phone: '010 9876 5432',
      bookingsCount: 12,
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=85',
      lastBooking: '24 مايو 2025',
      favoriteService: 'حلاقة كلاسيكية',
    ),
    AdminClientModel(
      id: 'c2',
      name: 'علي محمود',
      phone: '011 2345 6789',
      bookingsCount: 8,
      imageUrl:
          'https://images.unsplash.com/photo-1615109398623-88346a601842?auto=format&fit=crop&w=500&q=85',
      lastBooking: '23 مايو 2025',
      favoriteService: 'حلاقة حديثة',
    ),
    AdminClientModel(
      id: 'c3',
      name: 'كريم رمضان',
      phone: '010 1111 2222',
      bookingsCount: 15,
      imageUrl:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=500&q=85',
      lastBooking: '22 مايو 2025',
      favoriteService: 'تنظيف بشرة',
    ),
    AdminClientModel(
      id: 'c4',
      name: 'يوسف خالد',
      phone: '012 3456 7890',
      bookingsCount: 6,
      imageUrl:
          'https://images.unsplash.com/photo-1607346256330-dee7af15f7c5?auto=format&fit=crop&w=500&q=85',
      lastBooking: '21 مايو 2025',
      favoriteService: 'تهذيب اللحية',
    ),
    AdminClientModel(
      id: 'c5',
      name: 'أحمد علاء',
      phone: '010 2222 3333',
      bookingsCount: 9,
      imageUrl:
          'https://images.unsplash.com/photo-1530268729831-4b0b9e170218?auto=format&fit=crop&w=500&q=85',
      lastBooking: '20 مايو 2025',
      favoriteService: 'حلاقة + لحية',
    ),
    AdminClientModel(
      id: 'c6',
      name: 'محمود السيد',
      phone: '011 5555 6666',
      bookingsCount: 7,
      imageUrl:
          'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?auto=format&fit=crop&w=500&q=85',
      lastBooking: '18 مايو 2025',
      favoriteService: 'صبغ شعر',
    ),
  ];
}
