import { fixupPluginRules } from '@eslint/compat';
import { FlatCompat } from '@eslint/eslintrc';
import eslint from '@eslint/js';
import prettier from 'eslint-plugin-prettier/recommended';
import path from 'path';
import {
  configs as tsEslintConfigs,
  parser as tsParser,
} from 'typescript-eslint';
import vueEslintParser from 'vue-eslint-parser';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
});

/**
 * @param {string} name the pugin name
 * @param {string} alias the plugin alias
 * @returns {import("eslint").Plugin}
 */
function legacyPlugin(name, alias = name) {
  const plugin = compat.plugins(name)[0]?.plugins?.[alias];

  if (!plugin) {
    throw new Error(`Unable to resolve plugin ${name} and/or alias ${alias}`);
  }

  return fixupPluginRules(plugin);
}

/** @type {import('eslint').Linter.Config[]} */
export default [
  {
    ignores: ['.yarn'],
  },
  eslint.configs.recommended,
  ...tsEslintConfigs.recommended,
  ...compat.extends(
    'plugin:import/typescript',
    'plugin:vue/vue3-essential',
    '@vue/eslint-config-typescript',
    '@vue/eslint-config-prettier/skip-formatting'
  ),
  prettier,
  {
    plugins: {
      import: legacyPlugin('eslint-plugin-import', 'import'),
    },
    settings: {
      'import/resolver': {
        typescript: {
          alwaysTryTypes: true,
          project: './tsconfig.json',
        },
      },
    },
    languageOptions: {
      parser: vueEslintParser,
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: __dirname,
        parser: tsParser,
        sourceType: 'module',
        ecmaVersion: 2018,
        ecmaFeatures: {
          globalReturn: false,
          impliedStrict: false,
          jsx: false,
        },
        extraFileExtensions: ['.vue'],
      },
    },
    rules: {
      'no-undef': 'off',

      // camelcase: [
      //   'warn',
      //   {
      //     properties: 'always',
      //     ignoreDestructuring: true,
      //   },
      // ],

      'arrow-parens': ['warn', 'always'],

      'no-restricted-imports': ['error', { patterns: ['../'] }],
      // 'no-console': ['warn', { allow: ['warn', 'error'] }],

      '@typescript-eslint/no-unused-vars': [
        'off',
        {
          argsIgnorePattern: '^_',
          varsIgnorePattern: '^_',
          caughtErrorsIgnorePattern: '^_',
        },
      ],
      '@typescript-eslint/consistent-type-imports': 'error',
      '@typescript-eslint/consistent-type-exports': 'error',
      '@typescript-eslint/consistent-type-assertions': 'error',
      '@typescript-eslint/no-non-null-assertion': 'error',
      '@typescript-eslint/no-unnecessary-boolean-literal-compare': 'error',
      '@typescript-eslint/consistent-type-definitions': ['error', 'type'],

      'import/first': 'error',
      'import/newline-after-import': 'error',
      'import/no-duplicates': 'error',
      'import/order': [
        'error',
        {
          groups: [
            ['external', 'builtin'],
            ['internal', 'parent', 'sibling', 'index', 'object'],
            ['type'],
          ],
          'newlines-between': 'always',
        },
      ],
    },
  },
];
