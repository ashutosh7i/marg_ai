import Header from "@/components/teacher/Header";
import Sidebar from "@/components/teacher/Sidebar";
import { classList } from "@/data/data";

function StudentsPage() {
  return (
    <>
      <Sidebar />
      <div className="ml-[16.975rem] bg-[#F3F4FF]">
        <Header title="Students" />
      </div>

      <div className="ml-[16.975rem] bg-[#F3F4FF]">
        <div className="mx-4 grid grid-cols-[40%_60%]">
          <div className="flex flex-col">
            {/* Class dropdown */}
            <div className="flex w-full items-center justify-center gap-6 rounded-3xl border bg-white p-6 shadow-sm">
              <h2 className="text-2xl font-medium text-[#303972]">
                Your Classes
              </h2>
              <select
                name="class"
                id="classes"
                className="rounded-xl bg-[#4D44B52B] px-6 py-2"
                style={{ boxShadow: "0px 4px 4px 0px rgba(0, 0, 0, 0.25)" }}
              >
                <option value="" className="text-center text-xs text-black">
                  Pick a Class
                </option>
                {classList.map((c, idx) => (
                  <option key={idx} value={c}>
                    {c}
                  </option>
                ))}
              </select>
            </div>

            {/* Student dropdown */}

            {/* Student list */}
          </div>

          {/* Student progress list */}
        </div>
      </div>
    </>
  );
}

export default StudentsPage;
