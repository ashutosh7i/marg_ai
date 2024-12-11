import { topPerformingStudents as topStudents } from "@/data/data";
import { useTranslation } from "react-i18next";
function TopStudentsList() {
  const { t } = useTranslation("teachers-top-students-list");
  return (
    <div className="mb-6 px-20">
      <div className="rounded-lg bg-white p-6 shadow-md">
        <h2 className="mb-6 text-3xl font-bold text-[#303972]">
          {t("heading")}
        </h2>

        <ul className="grid grid-cols-1 gap-6">
          {topStudents.map((student, index) => (
            <li
              key={student.name}
              className="flex items-center justify-between"
            >
              <div className="flex items-center gap-4">
                <div className="flex h-10 w-10 items-center justify-center rounded-full bg-[#F3F4FF] text-lg font-bold text-[#303972]">
                  {index + 1}
                </div>
                <span className="text-lg font-medium text-[#303972]">
                  {student.name}
                </span>
              </div>
              <div className="text-lg font-bold text-[#303972]">
                {student.percentage}%
              </div>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}

export default TopStudentsList;
