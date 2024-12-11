import LanguageSelector from "@/components/teacher/LanguageSelector";
import Sidebar from "@/components/teacher/Sidebar";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import { Link } from "react-router";

function AssessmentsPage() {
  return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">Assessment</h1>
        <div className="flex items-center gap-12">
          <div className="flex items-center gap-3">
            {/* Search */}
            <Link
              to="/assessments/create"
              className="rounded-full border-none bg-[#4D44B5] px-4 py-2 text-2xl font-[550] text-white shadow-sm hover:bg-[#4D44B5]/80"
            >
              Create New Assessment
            </Link>

            {/* Language dropdown */}
            <LanguageSelector />
          </div>

          <TeacherAvatar />
        </div>
      </header>
    </>
  );
}

export default AssessmentsPage;
