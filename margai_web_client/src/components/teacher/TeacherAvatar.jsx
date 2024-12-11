import { Link } from "react-router";

function TeacherAvatar() {
  return (
    <Link to="/teacher/user" className="flex cursor-pointer items-center gap-2">
      <div className="font-poppins flex flex-col items-center justify-center gap-2">
        <h2 className="text-sm font-semibold text-[#303972]">Teacher_Name</h2>
        <p className="text-sm font-normal text-[#A098AE]">Teacher</p>
      </div>

      <div className="h-[5rem] w-[6rem] overflow-hidden rounded-[0.5995rem] bg-[#4D44B5] p-2 text-white">
        <img
          src="/img/avatar.png"
          alt="avatar"
          className="m-auto h-auto w-[2.5rem]"
        />
      </div>
    </Link>
  );
}

export default TeacherAvatar;
