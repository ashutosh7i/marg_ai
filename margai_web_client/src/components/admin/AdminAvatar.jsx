function TeacherAvatar() {
  return (
    <div to="/teacher/user" className="flex cursor-pointer items-center gap-2">
      <div className="font-poppins flex flex-col items-center justify-center gap-2">
        <h2 className="text-sm font-semibold text-[#00494A]">Admin_Name</h2>
        <p className="text-sm font-normal text-[#929292]">Admin</p>
      </div>

      <div className="h-[5rem] w-[6rem] overflow-hidden rounded-[0.5995rem] bg-[#018183] p-2 text-white">
        <img
          src="/img/avatar.png"
          alt="avatar"
          className="m-auto h-auto w-[2.5rem]"
        />
      </div>
    </div>
  );
}

export default TeacherAvatar;
