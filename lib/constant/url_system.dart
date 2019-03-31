
/////////////////////////// ยูเซอร์ ////////////////////////////////////////////

const url_login = 'https://project-changepart.herokuapp.com/login'; //ล็อคอิน
const url_create_user = 'https://project-changepart.herokuapp.com/user/create'; //สร้าง user
const url_user_byid = 'https://project-changepart.herokuapp.com/user/'; //อัพเดทข้อมูลผู้ใช้,ลบข้อมูล,//แสดงผู้ใช้ทั้งหมด
const url_select_user = 'https://project-changepart.herokuapp.com/user'; //อัพเดทข้อมูลผู้ใช้,ลบข้อมูล,//แสดงผู้ใช้ทั้งหมด
const url_user = 'https://project-changepart.herokuapp.com/user'; //ดูยูสเซอร์ทั้งหมด
///////////////////////// สต็อค ///////////////////////////////////////////////

const url_stock = 'https://project-changepart.herokuapp.com/stock'; //เพิ่มสต็อก
const url_get_stock_rank = 'https://project-changepart.herokuapp.com/stock/All/'; //เรียกดูสต็อกตามตำแหน่ง
const url_stock_byid = 'https://project-changepart.herokuapp.com/stock/'; //เรียกดูสต็อกตาม ไอดี , ลบสต็อค , อัพเดท

////////////////////////// แผนก //////////////////////////////////////////////////
const url_create_department = 'https://project-changepart.herokuapp.com/department'; //สร้างแผนก
const url_select_department = 'https://project-changepart.herokuapp.com/department'; //เรียกดูแผนก
const url_insret_department_id = 'https://project-changepart.herokuapp.com/department/:id'; //เรียกดูแผนกตามไอดี , อัพเดทข้อมูล ดีพาทเม้น ,ลบรายการ แผนก
const url_insret_department_name = 'https://project-changepart.herokuapp.com/department/checkname/:name'; //เรียกดูแผนกตามชื่อแผนก

/////////////////////////  log /////////////////////////////////////////

const url_create_log = 'https://project-changepart.herokuapp.com/logs'; //สร้าง log ,ดู log ทั้งหมด
const url_delete_log = 'https://project-changepart.herokuapp.com/logs:id'; //ลบ log

/////////////////////////// เพิ่มรายการเปลี่ยน อะไหล่ //////////////////////////////////

const url_insert_part = 'https://project-changepart.herokuapp.com/change'; //เพิ่มรายการอะไหล่
const url_select_list_part = 'https://project-changepart.herokuapp.com/change/All/'; ///เรียกดูรายการอะไหล่
const url_search_list_system = 'https://project-changepart.herokuapp.com/change/:id'; //ค้นหารายการอะไหล่ตามไอดี , อัพเดทรายการอะไหล่ ,ลบรายการอะไหล่
const url_delate_chang = 'https://project-changepart.herokuapp.com/change/';
const url_update_part = 'https://project-changepart.herokuapp.com/change/';
const url_upload_part = 'https://project-changepart.herokuapp.com/change/upload';
////////////////////////////  อัพรูป /////////////////////////////////////////

const url_upload_pic = 'https://project-changepart.herokuapp.com'; //อัพโหลดรูป

////////////////เค้าท์ //////////////////////////////
const url_cout_rank = 'https://project-changepart.herokuapp.com/stockcount/';
const url_cout_change = 'https://project-changepart.herokuapp.com/changecount/';













