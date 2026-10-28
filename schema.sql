-- Supabase starter schema for Kauthar School.
-- Run in Supabase SQL Editor. Review/test before entering real student data.
create extension if not exists pgcrypto;

create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  role text not null check (role in ('admin','teacher','student')),
  active boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists public.students (
  id uuid primary key default gen_random_uuid(),
  full_name text not null,
  phone text,
  stage text not null check (stage in ('ابتدائي','متوسط','إعدادي')),
  class_name text not null,
  profile_id uuid unique references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.grades (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  subject text not null,
  score numeric(5,2) not null check (score >= 0 and score <= 100),
  term text not null,
  teacher_id uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create table if not exists public.attendance (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  attendance_date date not null default current_date,
  status text not null check (status in ('حاضر','غائب','متأخر')),
  recorded_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now(),
  unique(student_id, attendance_date)
);

create table if not exists public.announcements (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  body text not null,
  created_by uuid references public.profiles(id) on delete set null,
  created_at timestamptz not null default now()
);

create or replace function public.current_role()
returns text language sql stable security definer
set search_path = public
as $$ select role from public.profiles where id = auth.uid() and active = true $$;

alter table public.profiles enable row level security;
alter table public.students enable row level security;
alter table public.grades enable row level security;
alter table public.attendance enable row level security;
alter table public.announcements enable row level security;

-- Profiles: users can read their own profile; admin can read/update all.
drop policy if exists "profiles_read_self_or_admin" on public.profiles;
create policy "profiles_read_self_or_admin" on public.profiles for select to authenticated
using (id = auth.uid() or public.current_role() = 'admin');
drop policy if exists "profiles_admin_update" on public.profiles;
create policy "profiles_admin_update" on public.profiles for update to authenticated
using (public.current_role() = 'admin') with check (public.current_role() = 'admin');

-- Students: admin and teachers can read; admin manages records.
drop policy if exists "students_read_staff" on public.students;
create policy "students_read_staff" on public.students for select to authenticated
using (public.current_role() in ('admin','teacher') or profile_id = auth.uid());
drop policy if exists "students_admin_insert" on public.students;
create policy "students_admin_insert" on public.students for insert to authenticated
with check (public.current_role() = 'admin');
drop policy if exists "students_admin_update" on public.students;
create policy "students_admin_update" on public.students for update to authenticated
using (public.current_role() = 'admin') with check (public.current_role() = 'admin');
drop policy if exists "students_admin_delete" on public.students;
create policy "students_admin_delete" on public.students for delete to authenticated
using (public.current_role() = 'admin');

-- Grades: staff read; admin/teacher insert and update. Students read their own grades.
drop policy if exists "grades_read_role" on public.grades;
create policy "grades_read_role" on public.grades for select to authenticated
using (public.current_role() in ('admin','teacher') or exists (
 select 1 from public.students s where s.id = student_id and s.profile_id = auth.uid()
));
drop policy if exists "grades_staff_insert" on public.grades;
create policy "grades_staff_insert" on public.grades for insert to authenticated
with check (public.current_role() in ('admin','teacher'));
drop policy if exists "grades_staff_update" on public.grades;
create policy "grades_staff_update" on public.grades for update to authenticated
using (public.current_role() in ('admin','teacher')) with check (public.current_role() in ('admin','teacher'));
drop policy if exists "grades_admin_delete" on public.grades;
create policy "grades_admin_delete" on public.grades for delete to authenticated
using (public.current_role() = 'admin');

-- Attendance: staff can read and record; students can read own attendance.
drop policy if exists "attendance_read_role" on public.attendance;
create policy "attendance_read_role" on public.attendance for select to authenticated
using (public.current_role() in ('admin','teacher') or exists (
 select 1 from public.students s where s.id = student_id and s.profile_id = auth.uid()
));
drop policy if exists "attendance_staff_insert" on public.attendance;
create policy "attendance_staff_insert" on public.attendance for insert to authenticated
with check (public.current_role() in ('admin','teacher'));
drop policy if exists "attendance_staff_update" on public.attendance;
create policy "attendance_staff_update" on public.attendance for update to authenticated
using (public.current_role() in ('admin','teacher')) with check (public.current_role() in ('admin','teacher'));
drop policy if exists "attendance_admin_delete" on public.attendance;
create policy "attendance_admin_delete" on public.attendance for delete to authenticated
using (public.current_role() = 'admin');

-- Announcements: all active authenticated users read; admin creates/updates/deletes.
drop policy if exists "announcements_read_active" on public.announcements;
create policy "announcements_read_active" on public.announcements for select to authenticated
using (public.current_role() in ('admin','teacher','student'));
drop policy if exists "announcements_admin_insert" on public.announcements;
create policy "announcements_admin_insert" on public.announcements for insert to authenticated
with check (public.current_role() = 'admin');
drop policy if exists "announcements_admin_update" on public.announcements;
create policy "announcements_admin_update" on public.announcements for update to authenticated
using (public.current_role() = 'admin') with check (public.current_role() = 'admin');
drop policy if exists "announcements_admin_delete" on public.announcements;
create policy "announcements_admin_delete" on public.announcements for delete to authenticated
using (public.current_role() = 'admin');

-- Important: create auth users first, then create profiles through a trusted admin workflow.
-- Do not make profile role/active writable by end users. Test policies using separate test accounts.
