import '../models/appointment_model.dart';
import '../models/barber_model.dart';
import '../models/service_model.dart';

class MockData {
  const MockData._();

  static const services = <ServiceModel>[
    ServiceModel(
      id: 'haircut',
      name: 'حلاقة شعر',
      description: 'حلاقة احترافية مع غسل وتجفيف',
      duration: '45 دقيقة',
      price: 80,
      imageUrl:
          'https://images.unsplash.com/photo-1622286346003-c8d5d47b176f?auto=format&fit=crop&w=600&q=85',
      category: 'الشعر',
    ),
    ServiceModel(
      id: 'beard',
      name: 'تهذيب اللحية',
      description: 'قص وتحديد اللحية باستخدام أدوات معقمة',
      duration: '30 دقيقة',
      price: 60,
      imageUrl:
          'https://images.unsplash.com/photo-1621605815971-fbc98d665033?auto=format&fit=crop&w=600&q=85',
      category: 'اللحية',
    ),
    ServiceModel(
      id: 'facial',
      name: 'تنظيف بشرة',
      description: 'تنظيف عميق وإزالة الشوائب',
      duration: '60 دقيقة',
      price: 120,
      imageUrl:
          'https://images.unsplash.com/photo-1570172619644-dfd03ed5d881?auto=format&fit=crop&w=600&q=85',
      category: 'البشرة',
    ),
    ServiceModel(
      id: 'haircare',
      name: 'عناية شعر',
      description: 'غسل وترطيب وعلاج للشعر',
      duration: '45 دقيقة',
      price: 70,
      imageUrl:
          'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?auto=format&fit=crop&w=600&q=85',
      category: 'الشعر',
    ),
    ServiceModel(
      id: 'dye',
      name: 'صبغ شعر',
      description: 'صبغ احترافي مع استشارة لون مناسبة',
      duration: '60 دقيقة',
      price: 150,
      imageUrl:
          'https://images.unsplash.com/photo-1560066984-138dadb4c035?auto=format&fit=crop&w=600&q=85',
      category: 'الشعر',
    ),
    ServiceModel(
      id: 'groom',
      name: 'باكدج العريس',
      description: 'حلاقة شعر، لحية، تنظيف بشرة وتجهيز كامل',
      duration: '120 دقيقة',
      price: 350,
      imageUrl:
          'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?auto=format&fit=crop&w=600&q=85',
      category: 'إضافات',
    ),
  ];

  static const barbers = <BarberModel>[
    BarberModel(
      id: 'ahmed',
      name: 'أحمد مسعود',
      specialty: 'خبير حلاقة رجال',
      rating: 4.8,
      reviews: '124 تقييم',
      imageUrl:
          'https://images.unsplash.com/photo-1618077360395-f3068be8e001?auto=format&fit=crop&w=500&q=85',
      status: 'متاح اليوم',
    ),
    BarberModel(
      id: 'mohamed',
      name: 'محمد سعيد',
      specialty: 'متخصص تهذيب اللحية',
      rating: 4.9,
      reviews: '98 تقييم',
      imageUrl:
          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&w=500&q=85',
      status: 'متاح اليوم',
    ),
    BarberModel(
      id: 'ali',
      name: 'علي الحكيم',
      specialty: 'خبير عناية شعر',
      rating: 4.7,
      reviews: '87 تقييم',
      imageUrl:
          'https://images.unsplash.com/photo-1615109398623-88346a601842?auto=format&fit=crop&w=500&q=85',
      status: 'مشغول',
    ),
    BarberModel(
      id: 'karim',
      name: 'كريم فوزي',
      specialty: 'باكدج العريس',
      rating: 4.9,
      reviews: '156 تقييم',
      imageUrl:
          'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=500&q=85',
      status: 'متاح غداً',
    ),
  ];

  static const upcomingAppointments = <AppointmentModel>[
    AppointmentModel(
      id: 'upcoming-1',
      serviceName: 'حلاقة شعر + تهذيب اللحية',
      barberName: 'أحمد مسعود',
      date: '24 يونيو',
      time: '04:00 م',
      status: 'مؤكد',
      price: 140,
    ),
    AppointmentModel(
      id: 'upcoming-2',
      serviceName: 'تنظيف بشرة',
      barberName: 'محمد سعيد',
      date: '30 يونيو',
      time: '02:00 م',
      status: 'مؤكد',
      price: 120,
    ),
  ];

  static const pastAppointments = <AppointmentModel>[
    AppointmentModel(
      id: 'past-1',
      serviceName: 'حلاقة شعر',
      barberName: 'علي الحكيم',
      date: '15 يونيو',
      time: '01:00 م',
      status: 'منتهي',
      price: 80,
    ),
  ];

  static const cancelledAppointments = <AppointmentModel>[];
}
