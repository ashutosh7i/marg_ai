import LanguageSelector from "@/components/teacher/LanguageSelector";
import Sidebar from "@/components/teacher/Sidebar";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";

function CreateAssessmentPage() {
    return (
    <>
      <Sidebar />
      <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
        <h1 className="text-4xl font-bold text-[#303972]">
          Create New Assessment
        </h1>
        <div className="flex items-center gap-12">
          <LanguageSelector />
          <TeacherAvatar />
        </div>
      </header>
    </>
  );
}

export default CreateAssessmentPage;
