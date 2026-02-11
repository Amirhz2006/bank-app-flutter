import 'package:flutter/material.dart';

class editProfile extends StatefulWidget {
  static const routeName = '/editProfile';
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _nameController = TextEditingController(text: 'سعید محمدی');
  final _usernameController = TextEditingController(text: 'saeed@dev.com');
  final _emailController = TextEditingController(text: 'saeed.mohammadi@gmail.com');
  final _phoneController = TextEditingController(text: '09123456789');
  final _nationalIdController = TextEditingController(text: '1234567890');
  String? _selectedGender;
  DateTime? _selectedDate;

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('اطلاعات با موفقیت ذخیره شد (نمایشی)')),
    );
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ویرایش پروفایل'),
          actions: [
            TextButton(
              onPressed: _saveProfile,
              child: const Text('ذخیره'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'نام و نام خانوادگی',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'نام کاربری',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'ایمیل',
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: 'شماره تلفن',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _nationalIdController,
                        decoration: const InputDecoration(
                          labelText: 'کد ملی',
                          prefixIcon: Icon(Icons.badge),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField(
                        value: _selectedGender,
                        decoration: const InputDecoration(
                          labelText: 'جنسیت (اختیاری)',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: null,
                            child: Text('انتخاب نشده'),
                          ),
                          DropdownMenuItem(
                            value: 'male',
                            child: Text('مرد'),
                          ),
                          DropdownMenuItem(
                            value: 'female',
                            child: Text('زن'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'تاریخ تولد (اختیاری)',
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'انتخاب نشده'
                                    : '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}',
                              ),
                              const Icon(Icons.calendar_month, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save),
                  label: const Text('ذخیره تغییرات'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.lock, color: Colors.orange),
                  label: const Text(
                    'تغییر رمز عبور',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}