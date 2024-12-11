//TODO: update imports

import SchoolCalendar from "@/components/admin/SchoolCalendar";
import Sidebar from "@/components/admin/Sidebar";
import Header from "@/components/admin/overview/Header";

function ExamSchedulePage() {
  return (
    <>
      <Sidebar />
      <Header />

      <main className="ml-[16.975rem] grid grid-cols-2 gap-4 bg-[#E8F9F9] pb-6 px-8">
        {/* TODO: make it reusable by passing head color */}
        <div className="w-full rounded-3xl border bg-white p-6 shadow-md">
          <h2 className="text-2xl font-bold text-[#125354] mb-4">
            Exam Schedules
          </h2>

          <ul className="flex flex-col gap-4">
            <li className="flex items-center justify-between rounded-xl bg-[#E8F9F9] p-6 shadow-sm transition-all hover:shadow-md">
              <div className="flex flex-col items-start">
                <h3 className="mb-1 text-xl font-bold text-[#333]">
                  Viva Examinations
                </h3>
                <button className="line-clamp-1 cursor-pointer text-xs font-semibold text-[#018183] underline">
                  View Schedule
                </button>
              </div>
              <div className="flex flex-col">
                <p className="text-[#8A8A8A] font-bold text-xs">
                  From 3rd Dec{" "}
                </p>
                <p className="text-[#8A8A8A] font-bold text-xs">Class X</p>
              </div>
            </li>

            <li className="flex items-center justify-between rounded-xl bg-[#E8F9F9] p-6 shadow-sm transition-all hover:shadow-md">
              <div className="flex flex-col">
                <h3 className="mb-1 text-xl font-bold text-[#333]">
                  Subject Quiz
                </h3>
                <button className="line-clamp-1 cursor-pointer text-xs font-semibold text-[#018183] underline">
                  View Schedule
                </button>
              </div>
              <div className=""></div>
            </li>
          </ul>
        </div>

        <SchoolCalendar
          events={{
            "2024-11-15": "TEST",
            "2024-11-20": "ASSIGNMENT",
          }}
        />
      </main>
    </>
  );
}

export default ExamSchedulePage;
