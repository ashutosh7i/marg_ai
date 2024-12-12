import LanguageSelector from "@/components/admin/LanguageSelector";
import Sidebar from "@/components/admin/Sidebar";
import AdminAvatar from "@/components/admin/AdminAvatar";
import Banner from "@/components/admin/overview/Banner";
import SchoolCalendar from "@/components/SchoolCalendar";
import { adminExams, recentStudents } from "@/data/data";
import ExamScheduleMessageCard from "@/components/admin/overview/ExamScheduleMessageCard";
import UserList from "@/components/admin/overview/UserList";
import { PieChart, Pie, Cell, Tooltip } from "recharts";

const scoreDistribution = [
  { name: "0-20%", value: 5 },
  { name: "20-40%", value: 10 },
  { name: "40-60%", value: 15 },
  { name: "60-80%", value: 20 },
  { name: "80-100%", value: 50 },
];

const COLORS = ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF"];

function OverviewPage() {
  return (
    <>
      <Sidebar />

      <div className="ml-[16.975rem] bg-[#E8F9F9] h-full pb-8">
        <header className="flex items-center justify-between px-10 py-6">
          <h1 className="text-4xl font-bold text-[#00494A]">Overview</h1>

          <div className="flex items-center gap-12">
            <div className="flex items-center gap-3">
              {/* Search */}
              <input
                type="text"
                placeholder="Search here..."
                className="font-poppins h-[2.75rem] w-[21.875rem] rounded-[2.5rem] bg-[#FFF] px-6 py-0 text-base font-normal text-[#00494A] shadow-sm placeholder:text-sm placeholder:text-[#A098AE] focus:outline-none"
              />

              {/* Language dropdown */}
              <LanguageSelector />
            </div>

            <AdminAvatar />
          </div>
        </header>
        {/**
         *
         * Row 1
         *
         *  */}
        <div className="mx-4 mb-8 grid grid-cols-[2fr_1fr] gap-4 items-center">
          {/* Banner */}
          <Banner />

          {/* Exam Schedule Message */}
          <ExamScheduleMessageCard exams={adminExams} />
        </div>

        {/**
         *
         * Row 2
         *
         *  */}
        <div className="grid grid-cols-2 gap-4 mx-4 mb-8">
          {/* Students Card */}
          <div className="w-full rounded-3xl border bg-white shadow-md p-6">
            <h2 className="text-2xl font-bold text-[#125354] mb-4">Students</h2>
            <div className="flex justify-center z-20">
              <PieChart width={400} height={400}>
                <Pie
                  data={scoreDistribution}
                  cx={200}
                  cy={200}
                  labelLine={false}
                  label={({ name, percent }) =>
                    `${name} ${(percent * 100).toFixed(0)}%`
                  }
                  outerRadius={150}
                  fill="#8884d8"
                  dataKey="value"
                >
                  {scoreDistribution.map((entry, index) => (
                    <Cell
                      key={`cell-${index}`}
                      fill={COLORS[index % COLORS.length]}
                    />
                  ))}
                </Pie>
                <Tooltip />
                {/* <Legend /> */}
              </PieChart>
            </div>

            <h3 className="text-center">
              The Institution&apos;s high school students are performing better
              than last two batches of your institute!!{" "}
            </h3>
          </div>

          {/* Calendar */}
          <SchoolCalendar
            events={{
              "2024-11-15": "TEST",
              "2024-11-20": "ASSIGNMENT",
            }}
            headingClass="text-[#125354]"
          />
        </div>

        {/**
         *
         * Row 3
         *
         *  */}
        <div className="grid grid-cols-3 gap-4 mx-4">
          {/* Exam Admin List */}
          <UserList title="Exam Admins" userList={recentStudents} />

          {/* Teachers List */}
          <UserList title="Teachers" userList={recentStudents} />

          {/* Students List */}
          <UserList title="Students" userList={recentStudents} />
        </div>
      </div>
    </>
  );
}

export default OverviewPage;
