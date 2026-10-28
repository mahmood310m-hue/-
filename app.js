import { createClient } from '@supabase/supabase-js';
import { SUPABASE_URL, SUPABASE_ANON_KEY } from './supabase-config.js';
const supabaseReady = SUPABASE_URL.startsWith('https://') && !SUPABASE_URL.includes('YOUR_PROJECT_REF') && !SUPABASE_ANON_KEY.includes('YOUR_SUPABASE');
const supabase = supabaseReady ? createClient(SUPABASE_URL, SUPABASE_ANON_KEY) : null;
const $ = (s)=>document.querySelector(s);
const DB_KEY='kauthar-school-v1';
const state={view:'home',data:{students:[],grades:[],attendance:[],announcements:[]},online:navigator.onLine,role:'demo'};
function load(){try{state.data={...state.data,...JSON.parse(localStorage.getItem(DB_KEY)||'{}')}}catch{}}
function save(){localStorage.setItem(DB_KEY,JSON.stringify(state.data));renderStats();$('#syncLabel').textContent=`مزامنة معلّقة: ${pendingCount()}`;}
function pendingCount(){return 0;} // TODO: replace with IndexedDB outbox + authenticated server sync.
function toast(msg){const el=$('#toast');el.textContent=msg;el.classList.remove('hidden');setTimeout(()=>el.classList.add('hidden'),3200)}
function escapeHtml(s){return String(s??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));}
function renderStats(){
 $('#studentCount').textContent=state.data.students.length;
 $('#attendanceCount').textContent=state.data.attendance.filter(x=>x.date===new Date().toISOString().slice(0,10)&&x.status==='حاضر').length;
 const nums=state.data.grades.map(x=>Number(x.score)).filter(Number.isFinite);
 $('#averageGrade').textContent=nums.length?(nums.reduce((a,b)=>a+b,0)/nums.length).toFixed(1):'—';
 $('#announcementCount').textContent=state.data.announcements.length;
 $('#connectionStatus').textContent=navigator.onLine?'● متصل بالإنترنت':'● دون اتصال — بيانات هذا الجهاز فقط';
}
function setView(view){state.view=view;document.querySelectorAll('[data-view]').forEach(b=>b.classList.toggle('active',b.dataset.view===view));renderView();}
function renderView(){
 const titles={home:'نظرة عامة',students:'إدارة الطلاب',grades:'الدرجات والمعدلات',attendance:'الحضور والغياب',announcements:'إعلانات المدرسة',more:'المزيد'};
 $('#viewTitle').textContent=titles[state.view]||'نظرة عامة';
 const host=$('#viewContent');
 if(state.view==='students'){host.innerHTML=`<form id="studentForm"><div class="form-row"><input name="name" placeholder="اسم الطالب" required><input name="phone" placeholder="رقم الهاتف (اختياري)"></div><div class="form-row"><select name="stage"><option>ابتدائي</option><option>متوسط</option><option>إعدادي</option></select><input name="className" placeholder="الصف / الشعبة" required></div><button class="primary-btn" type="submit">إضافة طالب</button></form><hr style="border:0;border-top:1px solid var(--line);margin:16px 0"><div class="row-list">${state.data.students.map((s,i)=>`<div class="list-row"><div><strong>${escapeHtml(s.name)}</strong><small>${escapeHtml(s.stage)} • ${escapeHtml(s.className)}</small></div><button class="mini-btn" data-delete-student="${i}">حذف</button></div>`).join('')||'<div class="empty-state">لا يوجد طلاب بعد. أضف أول طالب من النموذج أعلاه.</div>'}</div>`;$('#studentForm').onsubmit=e=>{e.preventDefault();const f=new FormData(e.target);state.data.students.push({id:crypto.randomUUID?.()||String(Date.now()),name:f.get('name').trim(),phone:f.get('phone').trim(),stage:f.get('stage'),className:f.get('className').trim()});save();renderView();toast('تمت إضافة الطالب إلى هذا الجهاز.');};host.querySelectorAll('[data-delete-student]').forEach(b=>b.onclick=()=>{state.data.students.splice(Number(b.dataset.deleteStudent),1);save();renderView()});return;}
 if(state.view==='grades'){host.innerHTML=`<form id="gradeForm"><div class="form-row"><select name="student" required><option value="">اختر الطالب</option>${state.data.students.map(s=>`<option>${escapeHtml(s.name)}</option>`).join('')}</select><input name="subject" placeholder="المادة" required></div><div class="form-row"><input name="score" type="number" min="0" max="100" step="0.5" placeholder="الدرجة من 100" required><input name="term" placeholder="الفصل الدراسي" value="الأول"></div><button class="primary-btn" type="submit">حفظ الدرجة</button></form><div class="row-list" style="margin-top:14px">${state.data.grades.map(g=>`<div class="list-row"><div><strong>${escapeHtml(g.student)} — ${escapeHtml(g.subject)}</strong><small>${escapeHtml(g.term)}</small></div><strong>${escapeHtml(g.score)} / 100</strong></div>`).join('')||'<div class="empty-state">أضف طالبًا أولًا، ثم سجّل درجاته.</div>'}</div>`;$('#gradeForm').onsubmit=e=>{e.preventDefault();const f=new FormData(e.target);state.data.grades.push({student:f.get('student'),subject:f.get('subject').trim(),score:Number(f.get('score')),term:f.get('term').trim()});save();renderView();toast('تم حفظ الدرجة محليًا.');};return;}
 if(state.view==='attendance'){host.innerHTML=`<form id="attendanceForm"><div class="form-row"><select name="student" required><option value="">اختر الطالب</option>${state.data.students.map(s=>`<option>${escapeHtml(s.name)}</option>`).join('')}</select><select name="status"><option>حاضر</option><option>غائب</option><option>متأخر</option></select></div><button class="primary-btn" type="submit">تسجيل الحضور</button></form><div class="row-list" style="margin-top:14px">${state.data.attendance.slice().reverse().map(a=>`<div class="list-row"><div><strong>${escapeHtml(a.student)}</strong><small>${escapeHtml(a.date)}</small></div><span class="pill">${escapeHtml(a.status)}</span></div>`).join('')||'<div class="empty-state">لا توجد سجلات حضور.</div>'}</div>`;$('#attendanceForm').onsubmit=e=>{e.preventDefault();const f=new FormData(e.target);state.data.attendance.push({student:f.get('student'),status:f.get('status'),date:new Date().toISOString().slice(0,10)});save();renderView();toast('تم تسجيل الحضور محليًا.');};return;}
 if(state.view==='announcements'){host.innerHTML=`<form id="announcementForm"><div class="form-row"><input class="full" name="title" placeholder="عنوان الإعلان" required><input class="full" name="body" placeholder="نص الإعلان" required></div><button class="primary-btn" type="submit">نشر إعلان على هذا الجهاز</button></form><div class="row-list" style="margin-top:14px">${state.data.announcements.slice().reverse().map(a=>`<div class="list-row"><div><strong>${escapeHtml(a.title)}</strong><small>${escapeHtml(a.body)} • ${escapeHtml(a.date)}</small></div></div>`).join('')||'<div class="empty-state">لا توجد إعلانات بعد.</div>'}</div>`;$('#announcementForm').onsubmit=e=>{e.preventDefault();const f=new FormData(e.target);state.data.announcements.push({title:f.get('title').trim(),body:f.get('body').trim(),date:new Date().toLocaleDateString('ar-IQ')});save();renderView();toast('تم حفظ الإعلان محليًا فقط.');};return;}
 if(state.view==='more'){host.innerHTML='<div class="empty-state">إعدادات الاتصال وقاعدة البيانات السحابية ستُفعّل بعد إضافة بيانات مشروع Supabase وإعداد سياسات الأمان.</div>';return;}
 host.innerHTML=`<div class="row-list"><div class="list-row"><div><strong>ابدأ بإضافة الطلاب</strong><small>أنشئ قائمة الطلاب والصفوف.</small></div><button class="mini-btn" data-view="students">فتح</button></div><div class="list-row"><div><strong>سجّل الدرجات</strong><small>يُحسب المتوسط من الدرجات المدخلة.</small></div><button class="mini-btn" data-view="grades">فتح</button></div><div class="list-row"><div><strong>تابع الحضور</strong><small>سجّل الحضور والغياب يوميًا.</small></div><button class="mini-btn" data-view="attendance">فتح</button></div></div>`;
 host.querySelectorAll('[data-view]').forEach(b=>b.onclick=()=>setView(b.dataset.view));
}
document.querySelectorAll('[data-view]').forEach(b=>b.addEventListener('click',()=>setView(b.dataset.view)));
$('#demoButton').addEventListener('click',()=>{load();$('#loginScreen').classList.add('hidden');$('#dashboard').classList.remove('hidden');$('#greeting').textContent='لوحة معاينة المدرسة';renderStats();setView('home');toast('أنت في وضع المعاينة؛ البيانات محفوظة على هذا الجهاز فقط.');});
$('#loginForm').addEventListener('submit', async e=>{
 e.preventDefault();
 if(!supabase){toast('أضف رابط مشروع Supabase والمفتاح العام في supabase-config.js أولًا.');return;}
 const phone=$('#phone').value.trim(), password=$('#password').value;
 try {
   const {data,error}=await supabase.auth.signInWithPassword({phone,password});
   if(error) throw error;
   const {data:profile,error:profileError}=await supabase.from('profiles').select('full_name,role,active').eq('id',data.user.id).single();
   if(profileError) throw profileError;
   if(!profile?.active) { await supabase.auth.signOut(); throw new Error('الحساب غير مفعّل. راجع إدارة المدرسة.'); }
   state.role=profile.role;
   $('#loginScreen').classList.add('hidden');$('#dashboard').classList.remove('hidden');
   $('#greeting').textContent=profile.full_name || 'حساب المدرسة';
   renderStats();setView('home');
   toast('تم تسجيل الدخول بنجاح.');
 } catch(err){toast(err.message || 'تعذر تسجيل الدخول. تحقق من البيانات وإعدادات المصادقة.');}
});
$('#syncButton').addEventListener('click',async()=>{
 if(!navigator.onLine){toast('لا يوجد اتصال. ستبقى بيانات المعاينة على هذا الجهاز.');return;}
 if(!supabase){toast('لم تُضبط بيانات Supabase بعد.');return;}
 toast('اتصال Supabase مهيأ؛ مزامنة جداول الطلاب والدرجات تحتاج إلى تنفيذ سياسات البيانات واختبارها.');
});
window.addEventListener('online',renderStats);window.addEventListener('offline',renderStats);
if('serviceWorker' in navigator)window.addEventListener('load',()=>navigator.serviceWorker.register('./sw.js').catch(()=>{}));
load();
