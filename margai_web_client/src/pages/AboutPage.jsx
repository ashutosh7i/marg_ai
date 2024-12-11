import LanguageSwitcher from "@/components/LanguageSwitcher";
import { useTranslation } from "react-i18next";

const AboutPage = () => {
  const { t } = useTranslation("about");

  return (
    <div>
      <LanguageSwitcher />
      <h1>{t("title")}</h1>
      <p>{t("content")}</p>
    </div>
  );
};

export default AboutPage;
