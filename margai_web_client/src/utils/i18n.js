import home from "@/translations/home";
import about from "@/translations/about";
import i18n from "i18next";
import { initReactI18next } from "react-i18next";

const resources = {
  en: {
    home: home.en,
    about: about.en,
  },
  fr: {
    home: home.fr,
    about: about.fr,
  },
};

i18n.use(initReactI18next).init({
  resources,
  lng: "en", // Default language
  fallbackLng: "en",
  interpolation: {
    escapeValue: false, // React already escapes content
  },
});

export default i18n;
