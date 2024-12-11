/* eslint-disable react/prop-types */

import LanguageSelector from "@/components/teacher/LanguageSelector";
import TeacherAvatar from "@/components/teacher/TeacherAvatar";
import { useTranslation } from "react-i18next";

function Header({ title }) {
  const { t } = useTranslation("teacher-header");
  return (
    <header className="flex items-center justify-between px-10 py-6">
      <h1 className="text-4xl font-bold text-[#303972]">{title}</h1>

      <div className="flex items-center gap-12">
        <div className="flex items-center gap-3">
          {/* Search */}
          <input
            type="text"
            placeholder={t("search")}
            className="font-poppins h-[2.75rem] w-[21.875rem] rounded-[2.5rem] bg-[#FFF] px-6 py-0 text-base font-normal text-[#4D44B5] shadow-sm placeholder:text-sm placeholder:text-[#A098AE] focus:outline-none"
          />

          {/* Language dropdown */}
          <LanguageSelector />
        </div>

        <TeacherAvatar />
      </div>
    </header>
  );
}

export default Header;
