import { useTranslation } from "react-i18next";
import { Link, useLocation } from "react-router";

function Sidebar() {
  const { pathname } = useLocation();
  const { t } = useTranslation("admin-sidebar");

  const menuItems = [
    {
      id: 1,
      name: t("Overview"),
      activeIcon: "/img/admin-sidebar/overview-active.svg",
      inactiveIcon: "/img/admin-sidebar/overview.svg",
      path: "/admin",
    },
    {
      id: 2,
      name: t("Students"),
      activeIcon: "/img/admin-sidebar/students-active.svg",
      inactiveIcon: "/img/admin-sidebar/students.svg",
      path: "/admin/students",
    },
    {
      id: 3,
      name: t("Teachers"),
      activeIcon: "/img/admin-sidebar/teachers-active.svg",
      inactiveIcon: "/img/admin-sidebar/teachers.svg",
      path: "/admin/teachers",
    },
    {
      id: 4,
      name: t("Exam Admins"),
      activeIcon: "/img/admin-sidebar/exam-admins-active.svg",
      inactiveIcon: "/img/admin-sidebar/exam-admins.svg",
      path: "/admin/exam-admins",
    },
    {
      id: 5,
      name: t("Assessments"),
      activeIcon: "/img/admin-sidebar/assessments-active.svg",
      inactiveIcon: "/img/admin-sidebar/assessments.svg",
      path: "/admin/assessments",
    },
    {
      id: 6,
      name: t("Exam Schedule"),
      activeIcon: "/img/admin-sidebar/exam-schedule-active.svg",
      inactiveIcon: "/img/admin-sidebar/exam-schedule.svg",
      path: "/admin/exam-schedule",
    },
    {
      id: 7,
      name: t("Institution"),
      activeIcon: "/img/admin-sidebar/institution-active.svg",
      inactiveIcon: "/img/admin-sidebar/institution.svg",
      path: "/admin/institution",
    },
  ];

  const isActiveRoute = (menuPath) => {
    if (menuPath === "/admin") {
      return pathname === "/admin";
    }
    return pathname.startsWith(menuPath);
  };

  return (
    <section className="fixed flex h-screen w-[16.975rem] flex-col items-center border border-[#4D44B5] border-r-[#F3F4FF] bg-[#018183] pt-8">
      <Link
        to="/admin"
        className="flex h-[2.88656rem] items-center pl-6 justify-center gap-2"
      >
        <img src="/img/logo.svg" alt="logo" height={45} width={45} />
        <h1 className="font-poppins lead text-[2rem] font-bold text-white">
          {/* {t("Title")} */}
          Marg AI
        </h1>
      </Link>

      <nav className="mt-4 flex flex-col gap-2 pl-4 w-full">
        {menuItems.map((menu) => (
          <Link
            to={menu.path}
            key={menu.id}
            className={`group w-full flex items-center gap-6 rounded-s-[2.5rem] px-6 py-2 text-lg font-medium hover:bg-[#F3F4FF] hover:text-[#018183] ${
              isActiveRoute(menu.path)
                ? "bg-[#F3F4FF] text-[#018183]"
                : "text-white"
            }`}
          >
            <img
              src={
                isActiveRoute(menu.path) || false
                  ? menu.activeIcon
                  : menu.inactiveIcon
              }
              className={`${
                !isActiveRoute(menu.path) ? "group-hover:hidden" : ""
              }`}
              alt={menu.name}
            />
            {!isActiveRoute(menu.path) && (
              <img
                src={menu.activeIcon}
                className="hidden group-hover:block"
                alt={menu.name}
              />
            )}
            <h2>{menu.name}</h2>
          </Link>
        ))}
      </nav>
    </section>
  );
}

export default Sidebar;
