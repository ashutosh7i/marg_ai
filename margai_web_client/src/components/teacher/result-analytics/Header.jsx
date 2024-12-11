import LanguageSelector from "../LanguageSelector";
import TeacherAvatar from "../TeacherAvatar";
import { useTranslation } from "react-i18next";

function Header() {
  const { t } = useTranslation("teacher-result-analytics-header");
  return (
    <header className="ml-[16.975rem] flex items-center justify-between bg-[#F3F4FF] px-10 py-6">
      <h1 className="text-4xl font-bold text-[#303972]">{t("header")}</h1>
      <div className="flex items-center gap-12">
        <LanguageSelector />
        <TeacherAvatar />
      </div>
    </header>
  );
}

export default Header;
