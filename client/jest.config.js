module.exports = {
  projects: ['<rootDir>'],
  roots: ['<rootDir>'],
  // Automatically clear mock calls and instances between every tests
  verbose: true,
  testEnvironment: 'jsdom',
  // globals: {
  //   window: {},
  // },
  // 각 테스트 종료 후, mock clear를 실행하기 위함
  // https://haeguri.github.io/2020/12/21/clean-up-jest-mock/
  restoreMocks: true,
  clearMocks: true,
  testMatch: ['<rootDir>/src/**/*.(spec|tests).[jt]s?(x)', '<rootDir>/tests/snapshot/**/*.tests.[jt]s?(x)'],
  setupFiles: ['<rootDir>/tests/jest.setup.js'],
  moduleDirectories: ['node_modules', 'src'],
};
